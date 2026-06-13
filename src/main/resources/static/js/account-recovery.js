
function initPage() {

    // ─────────────────────────────────────────────
    // STATE
    // ─────────────────────────────────────────────
    let recoveryEmail = '';
    let resendTimerInterval = null;

    // ─────────────────────────────────────────────
    // ELEMENTS
    // ─────────────────────────────────────────────
    const $emailSection        = $('#email-section');
    const $confirmationSection = $('#confirmation-section');
    const $passwordSection     = $('#password-section');

    const $emailInput          = $('[name="email"]');
    const $passwordInput       = $('[name="password"]');

    const $sendCodeBtn         = $('#send-code-btn');
    const $confirmBtn          = $('#confirm-btn');
    const $updateBtn           = $('#update-btn');
    const $resendBtn           = $('#resend-btn');
    const $backToEmailBtn      = $('#back-to-email-btn');

    const $emailWarning        = $('#emailWarningText');
    const $confirmWarning      = $('#confirmWarningText');
    const $passwordWarning     = $('#passwordWarningText');

    const $codeBoxes           = $('.code-box');


    // ─────────────────────────────────────────────
    // FADE
    // ─────────────────────────────────────────────
    function fadeTo($hide, $show) {
        $hide.addClass('hidden');
        setTimeout(() => {
            $hide.hide();
            $show.css('display', 'flex');
            setTimeout(() => $show.removeClass('hidden'), 10);
        }, 400);
    }


    // ─────────────────────────────────────────────
    // RESEND TIMER
    // ─────────────────────────────────────────────
    function setResendAvailable() {
        $resendBtn
            .prop('disabled', false)
            .css({ opacity: '1', cursor: 'pointer' })
            .text('Resend');
    }

    function startResendTimer(seconds) {
        $resendBtn
            .prop('disabled', true)
            .css({ opacity: '0.4', cursor: 'not-allowed' })
            .text(`RESEND IN ${seconds}s`);

        if (resendTimerInterval) clearInterval(resendTimerInterval);

        resendTimerInterval = setInterval(() => {
            seconds--;
            $resendBtn.text(`RESEND IN ${seconds}s`);
            if (seconds <= 0) {
                clearInterval(resendTimerInterval);
                setResendAvailable();
            }
        }, 1000);
    }


    // ─────────────────────────────────────────────
    // CODE BOXES
    // ─────────────────────────────────────────────
    function getCode() {
        return $codeBoxes.map(function () { return this.value; }).get().join('');
    }

    function resetCodeBoxes() {
        $codeBoxes.val('');
        $confirmWarning.text('');
        updateConfirmState();
    }

    function updateConfirmState() {
        $confirmBtn.prop('disabled', getCode().length !== 6);
    }

    function setConfirmLoading(isLoading) {
        if (isLoading) {
            $confirmBtn.prop('disabled', true).html('<span class="spinner"></span>');
        } else {
            $confirmBtn.text('CONFIRM →');
            updateConfirmState();
        }
    }

    $codeBoxes.each(function (index) {
        const $box = $(this);

        $box.on('keydown', function (e) {

            if (e.key === 'Enter') {
                if (getCode().length === 6 && !$confirmBtn.prop('disabled')) {
                    e.preventDefault();
                    $confirmBtn.trigger('click');
                }
                return;
            }

            if ((e.ctrlKey || e.metaKey) && e.key === 'v') return;

            if (e.key === 'Backspace') {
                e.preventDefault();
                if ($box.val()) {
                    $box.val('');
                } else if (index > 0) {
                    $codeBoxes.eq(index - 1).val('').focus();
                }
                updateConfirmState();
                return;
            }

            if (['Delete', 'Tab', 'ArrowLeft', 'ArrowRight'].includes(e.key)) return;

            if (!/^[0-9]$/.test(e.key)) { e.preventDefault(); return; }

            $box.val(e.key);
            updateConfirmState();
            if (index < $codeBoxes.length - 1) $codeBoxes.eq(index + 1).focus();
            e.preventDefault();
        });

        $box.on('paste', function (e) {
            e.preventDefault();
            const pasted = e.originalEvent.clipboardData.getData('text')
                .replace(/[^0-9]/g, '').slice(0, 6);
            pasted.split('').forEach((char, i) => { if ($codeBoxes[i]) $codeBoxes[i].value = char; });
            $codeBoxes.eq(Math.min(pasted.length - 1, 5)).focus();
            updateConfirmState();
        });
    });


    // ─────────────────────────────────────────────
    // SHOW CONFIRMATION
    // ─────────────────────────────────────────────
    async function showConfirmation() {
        const res = await fetch(`/api/auth/resend-cooldown?email=${recoveryEmail}&purpose=recovery`);
        const secondsRemaining = await res.json();

        fadeTo($emailSection, $confirmationSection);
        resetCodeBoxes();

        secondsRemaining > 0 ? startResendTimer(secondsRemaining) : setResendAvailable();
    }


    // ─────────────────────────────────────────────
    // EMAIL SECTION  —  Send Code
    // ─────────────────────────────────────────────
    function setSendCodeLoading(isLoading) {
        if (isLoading) {
            $sendCodeBtn.prop('disabled', true).html('<span class="spinner"></span>');
        } else {
            $sendCodeBtn.prop('disabled', false).text('SEND CODE');
        }
    }

    async function handleSendCode() {
        const email = $emailInput.val().trim();

        if (!/^[^\s@]+@[^\s@]+\.[a-zA-Z]{2,}$/.test(email)) {
            $emailWarning.text('* Please enter a valid email *');
            return;
        }

        $emailWarning.text('');
        setSendCodeLoading(true);

        const emailExists = await fetch(`/api/auth/check-email?email=${email}`).then(r => r.json());
        if (!emailExists) {
            $emailWarning.text('* No account found with that email *');
            setSendCodeLoading(false);
            return;
        }

        const res  = await fetch(`/api/auth/send-code?email=${email}&purpose=recovery`, { method: 'POST' });
        const body = await res.text();

        if (body === 'EMAIL_FAILED' || body === 'FAILED') {
            $emailWarning.text('* Failed to send code, please try again *');
            setSendCodeLoading(false);
            return;
        }

        // ACTIVE_CODE_EXISTS → valid code already out there, just show confirmation
        recoveryEmail = email;
        setSendCodeLoading(false);
        await showConfirmation();
    }

    $sendCodeBtn.on('click', handleSendCode);
    $emailInput.on('keydown', e => { if (e.key === 'Enter') { e.preventDefault(); handleSendCode(); } });


    // ─────────────────────────────────────────────
    // CONFIRMATION SECTION  —  Back
    // ─────────────────────────────────────────────
    $backToEmailBtn.on('click', function () {
        if (resendTimerInterval) clearInterval(resendTimerInterval);
        fadeTo($confirmationSection, $emailSection);
    });


    // ─────────────────────────────────────────────
    // CONFIRMATION SECTION  —  Resend
    // ─────────────────────────────────────────────
    $resendBtn.on('click', async function () {
        $resendBtn.prop('disabled', true)
                  .css({ opacity: '0.4', cursor: 'not-allowed' })
                  .html('<span class="spinner"></span>');

        const res = await fetch(`/api/auth/resend-code?email=${recoveryEmail}&purpose=recovery`, { method: 'POST' });

        if (res.status === 429) {
            startResendTimer(Number(await res.text()));
            return;
        }

        if (!res.ok) {
            $confirmWarning.text('* Failed to resend code *');
            setResendAvailable();
            return;
        }

        resetCodeBoxes();
        $codeBoxes.first().focus();
        $confirmWarning.text('* Code resent! *');
        startResendTimer(60);
    });


    // ─────────────────────────────────────────────
    // CONFIRMATION SECTION  —  Confirm Code
    // ─────────────────────────────────────────────
    $confirmBtn.on('click', async function () {
        const code = getCode();
        if (code.length < 6) {
            $confirmWarning.text('* Please enter the full 6-digit code *');
            return;
        }

        setConfirmLoading(true);

        const res = await fetch(
            `/api/auth/verify-code?email=${recoveryEmail}&code=${code}&purpose=recovery`,
            { method: 'POST' }
        );

        switch (res.status) {
            case 410:
                $confirmWarning.text('* Code expired, please request a new one *');
                setTimeout(() => fadeTo($confirmationSection, $emailSection), 2000);
                return;
            case 404:
                $confirmWarning.text('* Code not found, please request a new one *');
                setTimeout(() => fadeTo($confirmationSection, $emailSection), 2000);
                return;
            case 400:
                $confirmWarning.text('* Invalid code *');
                setConfirmLoading(false);
                return;
        }

        if (!res.ok) {
            $confirmWarning.text('* Invalid code *');
            setConfirmLoading(false);
            return;
        }

        setConfirmLoading(false);
        fadeTo($confirmationSection, $passwordSection);
        $passwordInput.focus();
    });


    // ─────────────────────────────────────────────
    // PASSWORD SECTION  —  Update
    // ─────────────────────────────────────────────
    function setUpdateLoading(isLoading) {
        if (isLoading) {
            $updateBtn.prop('disabled', true).html('<span class="spinner"></span>');
        } else {
            $updateBtn.prop('disabled', false).text('UPDATE');
        }
    }

    async function handleUpdate() {
        const password = $passwordInput.val().trim();

        if (!password || password.length < 8) {
            $passwordWarning.text('* Password must be at least 8 characters *');
            return;
        }

        $passwordWarning.text('');
        setUpdateLoading(true);

        const res = await fetch(
            `/api/auth/update-password?email=${recoveryEmail}&password=${encodeURIComponent(password)}`,
            { method: 'POST' }
        );

        if (!res.ok) {
            $passwordWarning.text('* Failed to update password, please try again *');
            setUpdateLoading(false);
            return;
        }

        window.location.href = '/login';
    }

    $updateBtn.on('click', handleUpdate);
    $passwordInput.on('keydown', e => { if (e.key === 'Enter') { e.preventDefault(); handleUpdate(); } });


    // ─────────────────────────────────────────────
    // INIT
    // ─────────────────────────────────────────────
    updateConfirmState();
};