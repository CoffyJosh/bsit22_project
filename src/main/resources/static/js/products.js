let productPage = 0;
const PRODUCT_PAGE_SIZE = 20;

let selectedProductStatus = '';
let productSearch = '';
let selectedProduct = null;

let searchDebounceTimer = null;

// Fetching Request
let currentDetailRequest = null;
let currentListRequest = null;

// Detail-view state
let originalGameData = null;
let imageChanged = {};
let providersCache = [];

$(document).ready(function () {
  fetchProducts();
  fetchProviders();
  showPlaceholder('empty');

  $('#nextPageBtn').on('click', goToNextProductPage);
  $('#prevPageBtn').on('click', goToPrevProductPage);

  $('.pagenav-input').on('keydown', function (e) {
    if (e.key !== 'Enter') return;
    e.preventDefault();

    const page = parseInt($(this).val(), 10);
    if (isNaN(page)) {
      $(this).val(productPage + 1);
      return;
    }

    const totalPages = parseInt($('#total-pages').text(), 10) || 1;
    const targetPage = Math.max(1, Math.min(page, totalPages));

    productPage = targetPage - 1;
    fetchProducts();
  });

  $(document).on('input', '.filter-options input', function () {
    const value = $(this).val();
    clearTimeout(searchDebounceTimer);
    searchDebounceTimer = setTimeout(() => {
      productSearch = value;
      productPage = 0;
      fetchProducts();
    }, 300);
  });

  $(document).on('click', '.product-item', function () {
    $('.product-item').removeClass('selected');
    $(this).addClass('selected');
    selectedProduct = $(this).data('game-id');

    showPlaceholder('loading');
    fetchProductDetails(selectedProduct);
  });

  // Change detection — text inputs (provider-name/merchant-id/api-key/secret-key removed)
  $(document).on('input', '#input-game-name, #input-package-name', updateSaveButtonState);

  // Change detection — dropdowns
  $(document).on('change', '#provider-select', function () {
    const providerId = $(this).val();
    populateProductDropdown(providerId, null); // null = no pre-selection, user is changing it
    updateSaveButtonState();
  });
  $(document).on('change', '#provider-product-select', updateSaveButtonState);

  // Change detection — status toggle
  $(document).on('change', 'input[name="game-status"]', updateSaveButtonState);

  $(document).on('click', '.image-upload-box', function () {
    const type = $(this).data('image-type');
    $(this).siblings(`.image-upload-input[data-image-type="${type}"]`).trigger('click');
  });

  $(document).on('change', '.image-upload-input', function () {
    const type = $(this).data('image-type');
    const file = this.files[0];
    if (!file) return;

    imageChanged[type] = true;

    const reader = new FileReader();
    reader.onload = function (e) {
      $(`.image-upload-box[data-image-type="${type}"]`)
        .removeClass('active')
        .addClass('updated')
        .css({
          'background-image': `url('${e.target.result}')`,
          'background-size': 'cover',
          'background-position': 'center'
        });
    };
    reader.readAsDataURL(file);

    updateSaveButtonState();
  });

  $(document).on('click', '#btn-save', function () {
    if ($(this).prop('disabled')) return;

    const $btn = $(this);
    $btn.prop('disabled', true);

    const formData = new FormData();
    formData.append('name', $('#input-game-name').val());
    formData.append('packageName', $('#input-package-name').val());
    formData.append('status', $('input[name="game-status"]:checked').val());

    const iconFile = $('.image-upload-input[data-image-type="icon"]')[0].files[0];
    const thumbFile = $('.image-upload-input[data-image-type="thumbnail"]')[0].files[0];
    const bannerFile = $('.image-upload-input[data-image-type="banner"]')[0].files[0];
    const packageFile = $('.image-upload-input[data-image-type="package"]')[0].files[0];

    if (iconFile) formData.append('icon', iconFile);
    if (thumbFile) formData.append('image', thumbFile);
    if (bannerFile) formData.append('banner', bannerFile);
    if (packageFile) formData.append('packageImage', packageFile);

    $.ajax({
      url: `/api/games/update/${selectedProduct}`,
      method: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function () {
        fetchProductDetails(selectedProduct); // reload to resync originalGameData
        fetchProducts(); // refresh list (name/status may have changed)
      },
      error: function (xhr) {
        console.error(xhr);
        $btn.prop('disabled', false); // re-enable so they can retry
      }
    });
  });
});


// =========================
// Helper Methods
// =========================
function showPlaceholder(state) {
  // state: 'empty' | 'loading'
  const $ph = $('#detail-placeholder');

  if (state === 'empty') {
    $ph.html(`
      <p class="placeholder-title">No Game Selected</p>
      <p class="placeholder-subtext">Click on a game from the list to view its details.</p>
    `);
  } else if (state === 'loading') {
    $ph.html(`
      <p class="placeholder-title">Loading...</p>
      <p class="placeholder-subtext">Fetching game details, please wait.</p>
    `);
  }

  $ph.show();
  $('#detail-panel-content').hide();
}

function showDetailContent() {
  $('#detail-placeholder').hide();
  $('#detail-panel-content').show();
}

function setupImageSlot(type, hasImage, imageUrl) {
  const $box = $(`.image-upload-box[data-image-type="${type}"]`);
  $box.css('background-image', '');
  $box.removeClass('active updated');
  $box.text(hasImage ? '' : '+');

  if (hasImage) {
    $box.addClass('active');
    $box.css({
      'background-image': `url('${imageUrl}')`,
      'background-size': 'cover',
      'background-position': 'center'
    });
  }
}

function setProductStatus($item, status) {
  const $statusBox = $item.find('.product-status-box');
  if ($statusBox.length === 0) return;

  $statusBox.removeClass('active inactive maintenance');
  const stat = status.toUpperCase();

  if (stat === 'ACTIVE' || stat === 'INACTIVE' || stat === 'MAINTENANCE') {
    $statusBox.addClass(stat.toLowerCase());
  }
  $statusBox.text(stat);
}

function formatProductDate(isoString) {
  const date = new Date(isoString);
  return date.toLocaleString('en-US', {
    month: 'short', day: 'numeric', year: 'numeric',
    hour: 'numeric', minute: '2-digit', hour12: true
  });
}

function formatCurrency(amount) {
  return Number(amount || 0).toLocaleString('en-US', { style: 'currency', currency: 'PHP' });
}

async function createProductItem(game) {
  const $item = $(`
    <div class="product-item">
      <div class="product-item-avatar"><img src=""></div>
      <div class="product-item-details-box">
        <div class="product-item-details">
          <p class="product-item-title"></p>
          <p class="product-item-subtitle"></p>
        </div>
        <div class="product-item-details" style="align-items: end;">
          <div class="product-status-box"></div>
          <p class="product-item-date"></p>
        </div>
      </div>
    </div>
  `);

  $item.css({
    'background-image': `
      linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)),
      url('/api/games/${game.id}/image/banner')
    `,
    'background-size': 'cover',
    'background-position': 'center',
  });

  $item.data('game-id', game.id);
  $item.find('.product-item-avatar img')
    .attr('src', `/api/games/${game.id}/image/icon`)
    .on('error', function () {
      $(this).off('error').attr('src', '/images/icon_placeholder.png');
    });
  $item.find('.product-item-title').text(game.name);
  $item.find('.product-item-subtitle').text(game.packageName);
  $item.find('.product-item-date').text(formatProductDate(game.createdAt));

  setProductStatus($item, game.status);
  return $item;
}


// =========================
// Data Fetching — list
// =========================

function fetchProducts() {
  if (currentListRequest) {
    currentListRequest.abort();
  }

  currentListRequest = $.ajax({
    url: '/api/games',
    method: 'GET',
    data: { page: productPage, size: PRODUCT_PAGE_SIZE, status: selectedProductStatus, search: productSearch },
    dataType: 'json',
    success: async function (response) {
      const $container = $('.product-list-container');
      $container.empty();

      if (response.content && response.content.length > 0) {
        const $items = await Promise.all(response.content.map(game => createProductItem(game)));
        $items.forEach($item => $container.append($item));
      }

      $('#nextPageBtn').prop('disabled', response.last);
      $('#prevPageBtn').prop('disabled', response.first);
      $('.pagenav-input').val(response.number + 1);
      $('#total-pages').text(response.totalPages || 1);
    },
    error: function (xhr) {
      if (xhr.statusText === 'abort') return;
      console.error(xhr);
    },
    complete: function () {
      currentListRequest = null;
    }
  });
}


// =========================
// Providers / Provider Products dropdown
// =========================

function fetchProviders() {
  $.ajax({
    url: '/api/providers',
    method: 'GET',
    success: function (providers) {
      providersCache = providers;
      const $select = $('#provider-select');
      $select.empty().append('<option value="">-- Select Provider --</option>');
      providers.forEach(p => {
        $select.append(`<option value="${p.id}">${p.name}</option>`);
      });
    },
    error: function (xhr) { console.error(xhr); }
  });
}

function populateProductDropdown(providerId, preselectProductId) {
  const $select = $('#provider-product-select');
  $select.empty().append('<option value="">-- Select Product --</option>');

  if (!providerId) return;

  $.ajax({
    url: `/api/providers/${providerId}/products`,
    method: 'GET',
    success: function (products) {
      products.forEach(p => {
        $select.append(`<option value="${p.id}">${p.productName}</option>`);
      });
      if (preselectProductId) {
        $select.val(preselectProductId);
      }
    },
    error: function (xhr) { console.error(xhr); }
  });
}


// =========================
// Data Fetching — single game detail
// =========================

function fetchProductDetails(gameId) {
  if (currentDetailRequest) {
    currentDetailRequest.abort();
  }

  currentDetailRequest = $.ajax({
    url: `/api/games/${gameId}/config-data`,
    method: 'GET',
    success: function (game) {
      populateProductDetails(game);
    },
    error: function (xhr) {
      if (xhr.statusText === 'abort') return; // expected, not a real error
      console.error(xhr);
    },
    complete: function () {
      currentDetailRequest = null;
    }
  });
}

function populateProductDetails(game) {
  showDetailContent();
  imageChanged = { icon: false, thumbnail: false, banner: false, package: false };
  originalGameData = {
    name: game.name,
    packageName: game.packageName,
    providerId: game.providerId || '',
    providerProductId: game.providerProductId || '',
    status: game.status
  };

  // Header stat strip
  $('#game-name').text(game.name);
  $('#package-name').text('Package: ' + game.packageName);
  $('.product-info-avatar img')
    .attr('src', `/api/games/${game.id}/image/icon`)
    .off('error')
    .on('error', function () { $(this).attr('src', '/images/icon_placeholder.png'); });

  // 4-column header stats
  $('#stat-total-sales').text(game.totalSales ?? 0);
  $('#stat-revenue').text(formatCurrency(game.revenue));
  $('#stat-packages').text(game.packagesCount ?? 0);
  $('#stat-date-created').text(formatProductDate(game.createdAt));

  // Text inputs
  $('#input-game-name').val(game.name);
  $('#input-package-name').val(game.packageName);

  // Provider dropdown — select provider, then load+preselect its product
  $('#provider-select').val(game.providerId || '');
  populateProductDropdown(game.providerId, game.providerProductId);

  // Status toggle
  $('input[name="game-status"]').prop('checked', false);
  $(`input[name="game-status"][value="${game.status}"]`).prop('checked', true);

  // Image slots
  setupImageSlot('icon', game.hasIcon, `/api/games/${game.id}/image/icon`);
  setupImageSlot('thumbnail', game.hasThumbnail, `/api/games/${game.id}/image/image`);
  setupImageSlot('banner', game.hasBanner, `/api/games/${game.id}/image/banner`);
  setupImageSlot('package', game.hasPackageImage, `/api/games/${game.id}/image/package`);

  updateSaveButtonState();
}


// =========================
// Change detection
// =========================

function hasUnsavedChanges() {
  if (!originalGameData) return false;

  const current = {
    name: $('#input-game-name').val(),
    packageName: $('#input-package-name').val(),
    providerId: $('#provider-select').val() || '',
    providerProductId: $('#provider-product-select').val() || '',
    status: $('input[name="game-status"]:checked').val()
  };

  const fieldsChanged = Object.keys(originalGameData).some(
    key => String(current[key]) !== String(originalGameData[key])
  );

  const anyImageChanged = Object.values(imageChanged).some(Boolean);

  return fieldsChanged || anyImageChanged;
}

function updateSaveButtonState() {
  $('#btn-save').prop('disabled', !hasUnsavedChanges());
}


// =========================
// Pagination
// =========================

function goToNextProductPage() { productPage++; fetchProducts(); }
function goToPrevProductPage() { if (productPage === 0) return; productPage--; fetchProducts(); }