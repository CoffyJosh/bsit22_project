let orderPage = 0;
const ORDER_PAGE_SIZE = 50;

let selectedStatus = '';
let selectedGame = '';
let selectedOrder = null;

let currentRequestId = 0;

$(document).ready(function () {
  fetchGameDropdown();
  fetchOrders();

  // Open / Close dropdown
  $(document).on('click', '.dropdown-selected', function () {
    const $dropdown = $(this).closest('.custom-dropdown');
    const isOpen = $dropdown.hasClass('open');

    $('.custom-dropdown').removeClass('open');

    if (!isOpen) {
      $dropdown.addClass('open');
    }
  });

  // Select dropdown option
  $(document).on('click', '.dropdown-option', function () {
    const $option = $(this);
    const $dropdown = $option.closest('.custom-dropdown');

    $dropdown.find('.dropdown-option').removeClass('selected');
    $option.addClass('selected');

    $dropdown.find('.dropdown-selected-text').text($option.text());

    const value = $option.data('value');

    if ($dropdown.attr('id') === 'gameFilterDropdown') {
      selectedGame = value;
    }

    if ($dropdown.attr('id') === 'statusFilterDropdown') {
      selectedStatus = value;
    }

    orderPage = 0;
    fetchOrders();

    $dropdown.removeClass('open');
  });

  // Close dropdown when clicking elsewhere
  $(document).on('click', function (e) {
    if (!$(e.target).closest('.custom-dropdown').length) {
      $('.custom-dropdown').removeClass('open');
    }
  });

  $('#nextPageBtn').on('click', goToNextPage);
  $('#prevPageBtn').on('click', goToPrevPage);

  // Typing page number
  $('.pagenav-input').on('keydown', function (e) {
    if (e.key !== 'Enter') return;

    e.preventDefault();

    const page = parseInt($(this).val(), 10);

    if (isNaN(page)) {
      $(this).val(orderPage + 1);
      return;
    }

    const totalPages = parseInt($('#total-pages').text(), 10) || 1;

    // Clamp page number
    const targetPage = Math.max(1, Math.min(page, totalPages));

    orderPage = targetPage - 1; // backend is zero-based

    fetchOrders();
  });

  // For selecting one of the packages
  $(document).on('click', '.order-item', function () {
    $('.order-item').removeClass('selected');
    $(this).addClass('selected');
    selectedOrder = $(this).data('order-id');
    console.log('Selected Order:', selectedOrder);

    fetchOrderDetails(selectedOrder);
  });
});


// =========================
// Helper Methods
// =========================

function setOrderStatus($orderItem, status) {
  const $statusBox = $orderItem.find('.order-status-box');

  if ($statusBox.length === 0) return;

  $statusBox.removeClass('complete pending failed');

  const stat = status.toUpperCase();

  if (
    stat !== 'COMPLETED' &&
    stat !== 'PENDING' &&
    stat !== 'FAILED'
  ) {
    $statusBox.text('UNKNOWN');
    return;
  }

  $statusBox.addClass(status.toLowerCase());
  $statusBox.text(stat);
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: 'numeric',
        minute: '2-digit',
        hour12: true
    });
}

function createOrderItem(order) {
  const $item = $(`
    <div class="order-item">
      <div class="order-item-avatar">
        <img src="">
      </div>

      <div class="order-item-details-box">

        <div class="order-item-details">
          <p class="order-item-title"></p>
          <p class="order-item-reference"></p>
          <p class="order-item-price"></p>
        </div>

        <div class="order-item-details" style="align-items: end;">
          <div class="order-status-box"></div>
          <p class="order-item-date"></p>
        </div>

      </div>
    </div>
  `);

  $item.data('order-id', order.orderId);

  // Insert image
  $item.find('.order-item-avatar img')
    .attr('src', `/api/games/${order.gameId}/image/icon`)
    .on('error', function () {
    $(this).off('error').attr('src', '/images/icon_placeholder.png');
  });


  $item.find('.order-item-title').text(order.gameName);
  $item.find('.order-item-reference').text('Ref: ' + order.trackingCode);
  $item.find('.order-item-price').text(
    '₱' +
    Number(order.finalAmount).toLocaleString(undefined, {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    })
  );

  $item.find('.order-item-date').text(formatOrderDate(order.createdAt));

  setOrderStatus($item, order.status);

  return $item;
}

function formatOrderDate(isoString) {
  const date = new Date(isoString);

  return date.toLocaleString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
    hour: 'numeric',
    minute: '2-digit',
    hour12: true
  });
}


// =========================
// Data Fetching
// =========================

function fetchGameDropdown() {
  $.ajax({
    url: '/api/games/all',
    method: 'GET',

    success: function (games) {
      const $container = $('#games-filter');

      $container.empty();

      $container.append(`
        <div class="dropdown-option selected" data-value="">
          All Games
        </div>
      `);

      games.forEach(g => {
        $container.append(`
          <div class="dropdown-option" data-value="${g.id}">
            ${g.name}
          </div>
        `);
      });
    },

    error: function (xhr) {
      console.error(xhr);
    }
  });
}

function fetchOrders() {
  const requestId = ++currentRequestId;

  $.ajax({
    url: '/api/orders',
    method: 'GET',

    data: {
      page: orderPage,
      size: ORDER_PAGE_SIZE,
      status: selectedStatus,
      gameId: selectedGame
    },

    dataType: 'json',

    success: function (response) {
      // Ignore stale responses from outdated requests
      if (requestId !== currentRequestId) return;

      const $container = $('.order-list-container');
      $container.empty();

      if (response.content && response.content.length > 0) {
        for (const order of response.content) {
          const $item = createOrderItem(order);
          $container.append($item);
        }
      }

      $('#nextPageBtn').prop('disabled', response.last);
      $('#prevPageBtn').prop('disabled', response.first);
      $('.pagenav-input').val(response.number + 1);
      $('#total-pages').text(response.totalPages || 1);
    },

    error: function (xhr) {
      console.error(xhr);
    }
  });
}

async function fetchOrderDetails(orderId) {
    // Clear it first 
    loadingOrderPlaceholder('.order-description-wrapper')


    // Fetch details
    const details = await $.ajax({
        url: `/api/orders/info`,
        method: 'GET',
        data: {
            orderId: orderId
        }
    });

    // Calculate discount for display
    const originalPrice = Number(details.packagePrice);
    let discountedPrice = originalPrice;

    if (details.discountValue) {
        if (details.discountType === 'FIXED') {
            discountedPrice = originalPrice - Number(details.discountValue);
        } else if (details.discountType === 'PERCENT') {
            discountedPrice = originalPrice * (1 - Number(details.discountValue) / 100);
        }

        // Prevent negative prices
        discountedPrice = Math.max(0, discountedPrice);

        // Optional: round to 2 decimal places
        discountedPrice = Number(discountedPrice.toFixed(2));
    }

    // Fetch Currency Image
    let currencyImageUrl = '';
    try {
        currencyImageUrl = await $.ajax({
            url: `/api/games/${details.gameId}/image/package`,
            method: 'GET'
        });

    } catch (err) {
        console.error('Failed to load currency image', err);
        currencyImageUrl = '/images/currency_placeholder.png';
    }

    // Price Display
    let priceHtml = '';
    if (details.discountValue) {
      let discountText = '';
      if (details.discountType === 'PERCENT') {
          discountText = `${details.discountValue}% OFF`;
      } else if (details.discountType === 'FIXED') {
          discountText = `₱${details.discountValue} OFF`;
      }
      
      priceHtml = `
        <p>₱${discountedPrice.toFixed(2)}</p>
        <div style="display: flex; align-items: center; gap: 4px; width: auto; margin: 0; flex-direction: column;">
          <div class="discount-box">${discountText}</div>
          <span style="color: #ffffff5d; font-size: 12px; text-decoration: line-through;">
            ₱${originalPrice.toFixed(2)}
          </span>
        </div>
      `;
    }
    else{
      priceHtml = `<p style="padding: 0 25px 0 0;">₱${originalPrice.toFixed(2)}</p>`
    }


    // Avatar Initial
    const avatarLetter = details.username
        ? details.username.charAt(0).toUpperCase()
        : '?';

    const html = `
        <div class="order-header">TRANSACTION DETAILS</div>
        <div class="order-description-grid">

          <div>
            <p class="order-title">Reference Number</p>
            <p class="order-value">${details.trackingCode}</p>
          </div>

          <div>
            <p class="order-title">Date</p>
            <p class="order-value">${formatDate(details.createdAt)}</p>
          </div>

          <div>
            <p class="order-title">Amount Paid</p>
            <p class="order-value">₱${Number(details.amountPaid).toFixed(2)}</p>
          </div>

          <div>
            <p class="order-title">Status</p>
            <p class="order-value">${details.status}</p>
          </div>

          <div>
            <p class="order-title">Payment Method</p>
            <p class="order-value">${details.paymentMethod}</p>
          </div>
        </div>

        <div class="order-header">ORDER DESCRIPTION</div>
        <div class="order-package">

          <div class="order-item-package">
            <img src="/api/games/${details.gameId}/image/package">
          </div>

          <div class="order-package-detail">
            <div class="order-detail-column">
              <p style="font-family:'Orbitron' ;font-weight: 500; font-size: 20px; margin: 3px 0;">${details.gameName}</p>
              <p style="font-family:'Rajdhani' ;font-weight: 400; font-size: 17px; margin: 3px 0;">${details.packageAmount} ${details.packageName}</p>
            </div>
            <div class="order-detail-price">
              ${priceHtml}
            </div>
          </div>

        </div>

        <br>
        <div class="order-header">CUSTOMER</div>
        <div class="customer-infobox">

          <p class="customer-avatar">${avatarLetter}</p>

          <div class="customer-info-grid">
            <div class="customer-info-text">
              <p style="color: rgba(255, 255, 255, 0.5); margin: 0 0 5px 0;">Username</p>
              <p style="color: rgb(255, 255, 255); margin: 0 0 5px 0; font-size: 14px;">${details.username}</p>
            </div>

            <div class="customer-info-text">
              <p style="color: rgba(255, 255, 255, 0.5); margin: 0 0 5px 0;">Email Address</p>
              <p style="color: rgb(255, 255, 255); margin: 0 0 5px 0; font-size: 14px;">${details.email}</p>
            </div>

            <div class="customer-info-text">
              <p style="color: rgba(255, 255, 255, 0.5); margin: 0 0 5px 0;">Game ID</p>
              <p style="color: rgb(255, 255, 255); margin: 0 0 5px 0; font-size: 14px;">${details.accountId}</p>
            </div>

          </div>

        </div>
    `;

    $('.order-description-wrapper').html(html);
}

function loadingOrderPlaceholder(target){
  $(target).html(`
    <div class="order-placeholder-state">
      <p class="placeholder-title">Loading Order Details...</p>
      <p class="placeholder-subtext">Please wait while we fetch the transaction.</p>
    </div>
  `);
}


// =========================
// Pagination
// =========================

function goToNextPage() {
  orderPage++;
  fetchOrders();
}

function goToPrevPage() {
  if (orderPage === 0) return;

  orderPage--;
  fetchOrders();
}