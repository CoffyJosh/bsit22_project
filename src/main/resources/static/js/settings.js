let originalUsername = '';

$(document).ready(function () {
  loadUserSettings();
  setupAccountForm();
  setupPasswordForm();
});

function loadUserSettings() {
  $.ajax({
    url: '/api/user/me',
    method: 'GET',
    success: function (user) {
      originalUsername = user.name;
      $('#settings-username').val(user.name);
    },
    error: function (xhr) {
      console.error(xhr);
    }
  });
}

function setupAccountForm() {
  const $username = $('#settings-username');
  const $saveBtn = $('#save-account-button');
  const $feedback = $('#account-feedback');

  function checkChanges() {
    const changed = $username.val() !== originalUsername;
    $saveBtn.prop('disabled', !changed);
  }

  $username.on('input', checkChanges);

  $saveBtn.on('click', function () {
    $saveBtn.prop('disabled', true);
    $feedback.removeClass('success error').text('');

    $.ajax({
      url: '/api/user/me',
      method: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify({ name: $username.val() }),
      success: function (user) {
        originalUsername = user.name;
        $feedback.addClass('success').text('Account updated successfully.');
      },
      error: function (xhr) {
        const msg = xhr.responseJSON?.message || 'Something went wrong, please try again.';
        $feedback.addClass('error').text(msg);
        $saveBtn.prop('disabled', false);
      }
    });
  });
}

function setupPasswordForm() {
  const $current = $('#current-password');
  const $newPass = $('#new-password');
  const $confirm = $('#confirm-new-password');
  const $saveBtn = $('#save-password-button');
  const $feedback = $('#password-feedback');

  let meetsRequirements = false;

  function showSpinner() {
    $saveBtn.prop('disabled', true);
    $('#save-password-text').hide();
    $('#save-password-spinner').show();
  }

  function hideSpinner() {
    $('#save-password-text').show();
    $('#save-password-spinner').hide();
  }

  $newPass.on('input', function () {
    const val = $newPass.val();

    const hasLength8 = val.length >= 8;
    const hasLength12 = val.length >= 12;
    const hasUpper = /[A-Z]/.test(val);
    const hasLower = /[a-z]/.test(val);
    const hasNumber = /[0-9]/.test(val);
    const hasSpecial = /[^A-Za-z0-9]/.test(val);

    updateRequirementBox('#req-length', hasLength8);
    updateRequirementBox('#req-case', hasUpper && hasLower);
    updateRequirementBox('#req-number', hasNumber);
    updateRequirementBox('#req-special', hasSpecial);

    let score = 0;
    if (hasLength8) score += 2;
    if (hasLength12) score += 2;
    if (hasUpper) score += 1;
    if (hasLower) score += 1;
    if (hasNumber) score += 1;
    if (hasSpecial) score += 2;

    meetsRequirements = hasLength8 && hasUpper && hasLower && hasNumber && hasSpecial;

    if (val.length === 0) {
      setStrength('Requirements', '0%', 'rgba(255,255,255,0.1)');
    } else if (!meetsRequirements) {
      setStrength(
        score >= 4 ? 'MEDIUM' : 'WEAK',
        score >= 4 ? '45%' : '25%',
        score >= 4 ? '#ffae00' : '#f54242'
      );
    } else if (score >= 10) {
      setStrength('STRONG', '100%', '#00cc66');
    } else if (score >= 7) {
      setStrength('GOOD', '80%', '#7CFF7C');
    } else {
      setStrength('MEDIUM', '55%', '#ffae00');
    }

    checkPasswordFormState();
  });

  $current.on('input', checkPasswordFormState);
  $confirm.on('input', checkPasswordFormState);

  function checkPasswordFormState() {
    const allFilled = $current.val() && $newPass.val() && $confirm.val();
    $saveBtn.prop('disabled', !(allFilled && meetsRequirements));
  }

  function updateRequirementBox(selector, met) {
    $(selector).css({
      borderColor: met ? '#00cc66' : '#ffffff23',
      color: met ? '#00cc66' : 'rgba(255,255,255,0.466)'
    });
  }

  function setStrength(label, width, color) {
    $('#settings-strength-label').text(label).css('color', color);
    $('#settings-strength-bar').css({ width: width, backgroundColor: color });
  }

  $saveBtn.on('click', function () {
    showSpinner();
    $feedback.removeClass('success error').text('');

    if ($newPass.val() !== $confirm.val()) {
      $feedback.addClass('error').text('Passwords do not match.');
      hideSpinner();
      $saveBtn.prop('disabled', false);
      return;
    }

    $.ajax({
      url: '/api/user/me/password',
      method: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify({
        currentPassword: $current.val(),
        newPassword: $newPass.val()
      }),
      success: function () {
        $current.val('');
        $newPass.val('');
        $confirm.val('');
        hideSpinner();
        $saveBtn.prop('disabled', true);
        setStrength('Requirements', '0%', 'rgba(255,255,255,0.1)');
        $('.requirement-box').css({ borderColor: '#ffffff23', color: 'rgba(255,255,255,0.466)' });
        $feedback.addClass('success').text('Password updated successfully.');
      },
      error: function (xhr) {
        const msg = xhr.responseJSON?.message || 'Failed to update password.';
        $feedback.addClass('error').text(msg);
        hideSpinner();
        $saveBtn.prop('disabled', false);
      }
    });
  });
}