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

  // Change detection — text inputs
  $(document).on('input', '#input-game-name, #input-package-name, #input-product-code', updateSaveButtonState);

  // Custom provider dropdown — open/close
  $(document).on('click', '.custom-dropdown .dropdown-selected', function () {
    const $dropdown = $(this).closest('.custom-dropdown');
    $('.custom-dropdown').not($dropdown).removeClass('open');
    $dropdown.toggleClass('open');
  });

  // Close dropdown when clicking outside
  $(document).on('click', function (e) {
    if (!$(e.target).closest('.custom-dropdown').length) {
      $('.custom-dropdown').removeClass('open');
    }
  });

  // Selecting a provider option
  $(document).on('click', '#provider-options .dropdown-option', function () {
    const id = $(this).data('id');
    const text = $(this).text();

    $('#providerFilterDropdown')
      .attr('data-selected-id', id)
      .find('.dropdown-selected-text').text(text);

    $('#providerFilterDropdown').removeClass('open');
    updateSaveButtonState();
  });

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
    formData.append('providerId', $('#providerFilterDropdown').attr('data-selected-id') || '');
    formData.append('productCode', $('#input-product-code').val() || '');

    const iconFile = $('.image-upload-input[data-image-type="icon"]')[0].files[0];
    const thumbFile = $('.image-upload-input[data-image-type="thumbnail"]')[0].files[0];
    const bannerFile = $('.image-upload-input[data-image-type="banner"]')[0].files[0];
    const packageFile = $('.image-upload-input[data-image-type="package"]')[0].files[0];

    if (iconFile) formData.append('icon', iconFile);
    if (thumbFile) formData.append('thumbnail', thumbFile);
    if (bannerFile) formData.append('banner', bannerFile);
    if (packageFile) formData.append('packageImage', packageFile);

    $.ajax({
      url: `/api/games/update/${selectedProduct}`,
      method: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function () {
        fetchProductDetails(selectedProduct);
        fetchProducts();
      },
      error: function (xhr) {
        console.error(xhr);
        $btn.prop('disabled', false);
      }
    });
  });


  // Deleting Game
  $(document).on('click', '#btn-delete', function () {
    $('#delete-overlay').css('display', 'flex');
  });

  $(document).on('click', '#delete-step1-cancel', function () {
    $('#delete-overlay').hide();
  });

  $(document).on('click', '#delete-step1-continue', function () {
    $('#delete-overlay').hide();
    $('#delete-confirm-overlay').css('display', 'flex');
  });

  $(document).on('click', '#delete-step2-cancel', function () {
    $('#delete-confirm-overlay').hide();
  });

  $(document).on('click', '#delete-step2-confirm', function () {
    $.ajax({
      url: `/api/games/${selectedProduct}/delete`,
      method: 'POST',
      success: function () {
        location.reload();
      },
      error: function (xhr) {
        console.error(xhr);
        $('#delete-confirm-overlay').hide();
      }
    });
  });
});


// =========================
// Helper Methods
// =========================
function showPlaceholder(state) {
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
      'background-image': `url('${imageUrl}?t=${Date.now()}')`,
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
    .attr('src', `/api/games/${game.id}/image/icon?t=${Date.now()}`)
    .on('error', function () {
      $(this).off('error').attr('src', '/images/icon_placeholder.png');
    });
  $item.find('.product-item-title').text(game.name);
  $item.find('.product-item-subtitle').text(game.packageName);
  $item.find('.product-item-date').text(formatProductDate(game.createdAt));

  setProductStatus($item, game.status);
  return $item;
}

function updateProductListItem(game) {
  const $item = $('.product-item').filter(function () {
    return $(this).data('game-id') === game.id;
  });

  if ($item.length === 0) return;

  $item.find('.product-item-title').text(game.name);
  $item.find('.product-item-subtitle').text(game.packageName);
  setProductStatus($item, game.status);

  if (imageChanged.banner) {
    $item.css({
      'background-image': `
        linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.85)),
        url('/api/games/${game.id}/image/banner?t=${Date.now()}')
      `,
      'background-size': 'cover',
      'background-position': 'center',
    });
  }

  if (imageChanged.icon) {
    $item.find('.product-item-avatar img')
      .attr('src', `/api/games/${game.id}/image/icon?t=${Date.now()}`);
  }
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
        const $items = await Promise.all(
          response.content
            .filter(game => game.status !== 'DEPRECATED')
            .map(game => createProductItem(game))
        );
        
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
// Providers dropdown (Provider only — product is now a plain text code)
// =========================

function fetchProviders() {
  $.ajax({
    url: '/api/provider/get-all',
    method: 'GET',
    success: function (providers) {
      providersCache = providers;
      const $options = $('#provider-options');
      $options.empty();
      providers.forEach(p => {
        $options.append(`<div class="dropdown-option" data-id="${p.providerId}">${p.providerName}</div>`);
      });

      console.log(providersCache);
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
      if (xhr.statusText === 'abort') return;
      console.error(xhr);
    },
    complete: function () {
      currentDetailRequest = null;
    }
  });
}

function populateProductDetails(game) {
  showDetailContent();
  updateProductListItem(game);
  imageChanged = { icon: false, thumbnail: false, banner: false, package: false };

  originalGameData = {
    name: game.name,
    packageName: game.packageName,
    providerId: game.providerId || '',
    productCode: game.productCode || '',
    status: game.status
  };

  // Header stat strip
  $('#game-name').text(game.name);
  $('#package-name').text('Package: ' + game.packageName);
  $('.product-info-avatar img')
    .attr('src', `/api/games/${game.id}/image/icon?t=${Date.now()}`)
    .off('error')
    .on('error', function () { $(this).attr('src', '/images/icon_placeholder.png'); });

  // 4-column header stats
  $('#total-sales').find('.info-value').text(game.totalSales ?? 0);
  $('#revenue-info').find('.info-value').text(formatCurrency(game.revenue));
  $('#package-info').find('.info-value').text(game.packagesCount ?? 0);
  $('#creation-info').find('.info-value').text(formatProductDate(game.createdAt));

  // Text inputs
  $('#input-game-name').val(game.name);
  $('#input-package-name').val(game.packageName);
  $('#input-product-code').val(game.productCode || '');

  // Provider dropdown — set selected via data attribute
  const provider = providersCache.find(p => p.providerId === game.providerId);
  $('#providerFilterDropdown')
    .attr('data-selected-id', game.providerId || '')
    .find('.dropdown-selected-text').text(provider ? provider.providerName : 'Select Provider');

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
    providerId: $('#providerFilterDropdown').attr('data-selected-id') || '',
    productCode: $('#input-product-code').val() || '',
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