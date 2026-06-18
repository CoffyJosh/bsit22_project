function initPage(){
  $('#send-link-btn').click(function (e){
    e.preventDefault();

    const btn = $(this);
    const backBtn = $(".back-button");
    const emailInput = $("#email");
    const warningText = $("#emailWarningText");

    warningText.text("");

    // disable EVERYTHING
    btn.prop("disabled", true);
    backBtn.prop("disabled", true);
    emailInput.prop("disabled", true);

    btn.html(`<span class="spinner"></span>`);

    const email = emailInput.val().trim();

    if (!email) {
        warningText.text("Please enter an email address.");

        // restore
        btn.prop("disabled", false).text("SEND LINK");
        backBtn.prop("disabled", false);
        emailInput.prop("disabled", false);
        return;
    }

    $.ajax({
        url: "/account-recovery",
        type: "POST",
        data: { email: email },

        success: function(response) {
            const container = $("#auth-form-content");
            container.css({ transition: "opacity 0.3s ease", opacity: "0" });
            setTimeout(() => {
                container.html(response);
                htmx.process(container[0]);
                setTimeout(() => container.css("opacity", "1"), 50);
            }, 300);
        },

        error: function() {
            warningText.text("An error occurred while sending the recovery email.");
            btn.prop("disabled", false).text("SEND LINK");
            backBtn.prop("disabled", false);
            emailInput.prop("disabled", false);
        }
    });
  });


  // ------------------------
  // PASSWORD STRENGTH
  // ------------------------
  const passwordInput = document.querySelector('[name="password"]');
  const strengthBar = document.querySelector('.strength-bar');
  const strengthText = document.querySelector('.requirement-strength');

  let meetsRequirements = false;

  if (passwordInput) {
    passwordInput.addEventListener('input', () => {
        const val = passwordInput.value;

        const upperCount = (val.match(/[A-Z]/g) || []).length;
        const specialCount = (val.match(/[^A-Za-z0-9]/g) || []).length;

        const has2Upper = upperCount >= 2;
        const has2Special = specialCount >= 2;

        const hasLength8 = val.length >= 8;
        const hasLength12 = val.length >= 12;

        const hasUpper = /[A-Z]/.test(val);
        const hasLower = /[a-z]/.test(val);
        const hasNumber = /[0-9]/.test(val);
        const hasSpecial = /[^A-Za-z0-9]/.test(val);

        updateBox(0, hasLength8);
        updateBox(1, hasUpper && hasLower);
        updateBox(2, hasNumber);
        updateBox(3, hasSpecial);

        let score = 0;

        if (hasLength8) score += 2;
        if (hasLength12) score += 2;

        if (hasUpper) score += 1;
        if (hasLower) score += 1;
        if (hasNumber) score += 1;
        if (hasSpecial) score += 2;

        if (has2Upper) score += 2;
        if (has2Special) score += 2;

        meetsRequirements =
            hasLength8 &&
            hasUpper &&
            hasLower &&
            hasNumber &&
            hasSpecial;

        if (val.length === 0) {
            setStrength('Requirements', '0%', '#FFFFFF77');
            return;
        }

        if (!meetsRequirements) {
            if (score >= 7) {
                setStrength('MEDIUM', '55%', '#ffae00ff');
            } else if (score >= 4) {
                setStrength('MEDIUM', '45%', '#ffae00ff');
            } else {
                setStrength('WEAK', '25%', '#f54242');
            }
            return;
        }

        if (score >= 12) {
            setStrength('STRONK', '100%', '#fffc50ff');
            return;
        }

        if (score >= 7) {
            setStrength('GOOD', '80%', '#7CFF7C');
            return;
        }

        if (score >= 4) {
            setStrength('MEDIUM', '55%', '#ffae00ff');
            return;
        }

        setStrength('WEAK', '25%', '#f54242');
    });
  }

  function updateBox(index, met) {
      const boxes = document.querySelectorAll('.requirement-box');
      boxes[index].style.borderColor = met ? '#00cc66' : '#ffffff23';
      boxes[index].style.color = met ? '#00cc66' : 'rgba(255,255,255,0.466)';
  }

  function setStrength(label, width, color) {
      strengthText.textContent = label;
      strengthText.style.color = color;
      strengthBar.style.width = width;
      strengthBar.style.backgroundColor = color;
  }

  const updateButton = $('#update-btn');
  const passwordField = $('#password-field');
  const confirmPasswordField = $('#confirm-password-field');

  if (updateButton.length) {
    updateButton.click(function(){
        const token = $("#token").val();
        const password = passwordField.val();
        const confirmPassword = confirmPasswordField.val();
        const warningText = $("#resetWarning");

        warningText.text("");

        if (!meetsRequirements) {
            warningText.text("Password does not meet requirements.");
            return;
        }

        if (password !== confirmPassword) {
            warningText.text("Passwords do not match.");
            return;
        }

        updateButton.prop("disabled", true).html(`<span class="spinner"></span>`);

        $.ajax({
            url: "/account-recovery/update-password",
            type: "POST",
            data: { token: token, password: password },

            success: function() {
                $("#reset-form-state").fadeOut(300, function() {
                    $("#reset-success-state").fadeIn(300);
                });
            },

            error: function(xhr) {
                warningText.text(xhr.responseText || "Something went wrong. Your link may have expired.");
                updateButton.prop("disabled", false).text("UPDATE");
            }
        });
    });
  }

}