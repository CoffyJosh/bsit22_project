function initPage() {

    // ------------------------
    // HELPERS
    // ------------------------
    function resetRegistrationUI() {
        // clear inputs
        document.querySelector('[name="name"]').value = '';
        document.querySelector('[name="email"]').value = '';
        document.querySelector('[name="password"]').value = '';
        document.querySelector('[name="confirm-password"]').value = '';

        // clear warning
        warningText.textContent = '';

        // reset password strength UI (optional but recommended)
        setStrength('Requirements', '0%', '#FFFFFF77');

        // reset checkbox
        checkbox.checked = false;

        // reset submit button state
        submitButton.disabled = true;
        submitButton.textContent = 'CREATE ACCOUNT +';
    }

    // ------------------------
    // CONTINOUS ENTERING FIELDS
    // ------------------------
    const inputs = document.querySelectorAll('.text-input, .password-input');
    const termsCheckbox = document.getElementById('terms');
    const registerBtn = document.getElementById('submit-registration');

    inputs.forEach((input, index) => {
        input.addEventListener('keydown', function (e) {

            if (e.key === 'Enter') {
                e.preventDefault();
                const nextInput = inputs[index + 1];

                // If another input exists
                if (nextInput) {
                    nextInput.focus();
                } else {
                    // LAST INPUT
                    if (!termsCheckbox.checked) {
                        termsCheckbox.focus();
                    } else {
                        // simulate button click
                        registerBtn.click();
                    }
                }
            }
        });
    });

    // ------------------------
    // STATE
    // ------------------------
    const warningText = document.getElementById('warningText');
    const confirmWarningText = document.getElementById('confirmWarningText');
    let userData = {};
    let resendTimerInterval = null;

    // ------------------------
    // FADE
    // ------------------------
    function fadeTo(hideEl, showEl) {
        hideEl.classList.add('hidden');
        setTimeout(() => {
            hideEl.style.display = 'none';
            showEl.style.display = 'flex';
            setTimeout(() => showEl.classList.remove('hidden'), 10);
        }, 400);
    }

    // ------------------------
    // PASSWORD STRENGTH
    // ------------------------
    const passwordInput = document.querySelector('[name="password"]');
    const strengthBar = document.querySelector('.strength-bar');
    const strengthText = document.querySelector('.requirement-strength');

    let meetsRequirements = false;

    passwordInput.addEventListener('input', () => {
        const val = passwordInput.value;

        // ------------------------
        // feature checks
        // ------------------------
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

        // ------------------------
        // UI requirement boxes
        // ------------------------
        updateBox(0, hasLength8);
        updateBox(1, hasUpper && hasLower);
        updateBox(2, hasNumber);
        updateBox(3, hasSpecial);

        // ------------------------
        // scoring system
        // ------------------------
        let score = 0;

        if (hasLength8) score += 2;
        if (hasLength12) score += 2;

        if (hasUpper) score += 1;
        if (hasLower) score += 1;
        if (hasNumber) score += 1;
        if (hasSpecial) score += 2;

        if (has2Upper) score += 2;
        if (has2Special) score += 2;

        // ------------------------
        // submission gate
        // ------------------------
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

        // ------------------------
        // ALL REQUIREMENT WASN'T MET
        // max = MEDIUM only
        // ------------------------
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

        // ------------------------
        // NORMAL PASSWORDS (8+ chars)
        // full system allowed
        // ------------------------
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

    // ------------------------
    // RESEND TIMER
    // ------------------------
    function setResendAvailable() {
        const resendButton = document.getElementById('resend-button');

        if (!resendButton) return; // prevent crash
        
        resendButton.disabled = false;
        resendButton.style.opacity = '1';
        resendButton.style.cursor = 'pointer';
    }

    function startResendTimer(seconds) {
        const resendButton = document.getElementById('resend-button');

        resendButton.disabled = true;
        resendButton.style.opacity = '0.4';
        resendButton.style.cursor = 'not-allowed';
        resendButton.textContent = `RESEND IN ${seconds}s`;

        if (resendTimerInterval) clearInterval(resendTimerInterval);

        resendTimerInterval = setInterval(() => {
            seconds--;
            resendButton.textContent = `RESEND IN ${seconds}s`;

            if (seconds <= 0) {
                clearInterval(resendTimerInterval);
                resendButton.disabled = false;
                resendButton.style.opacity = '1';
                resendButton.style.cursor = 'pointer';
                resendButton.textContent = 'RESEND CODE';
            }
        }, 1000);
    }

    // ------------------------
    // SHOW CONFIRMATION
    // checks backend for existing cooldown on this email
    // so if user goes back and resubmits same/different email
    // the resend button state is always accurate
    // ------------------------
    async function showConfirmation(email) {
        const reg = document.getElementById('registration-section');
        const conf = document.getElementById('confirmation-section');

        // check backend for remaining cooldown for this email
        const cooldownRes = await fetch(`/api/auth/resend-cooldown?email=${email}&purpose=registration`);
        const secondsRemaining = await cooldownRes.json();

        fadeTo(reg, conf);

        if (secondsRemaining > 0) {
            startResendTimer(secondsRemaining);
        } else {
            setResendAvailable();
        }
    }


    // ------------------------
    // SUBMIT BUTTON
    // ------------------------

    const checkbox = document.querySelector('.check-box-label');
    const submitButton = document.getElementById('submit-registration');

    function updateSubmitState() {
        const name = document.querySelector('[name="name"]').value.trim();
        const email = document.querySelector('[name="email"]').value.trim();
        const password = document.querySelector('[name="password"]').value.trim();
        const confirmPassword = document.querySelector('[name="confirm-password"]').value.trim();

        const allFilled = name && email && password && confirmPassword;

        submitButton.disabled = !(allFilled && checkbox.checked);
    }

    function setSubmitLoading(isLoading) {
        submitButton.disabled = isLoading;

        if (isLoading) {
            submitButton.innerHTML = '<span class="spinner"></span>';
        } else {
            submitButton.textContent = 'CREATE ACCOUNT +';
            updateSubmitState(); // re-evaluate rules after loading
        }
    }

    // initial state (IMPORTANT)
    updateSubmitState();

    // listeners for live validation
    document.querySelector('[name="name"]').addEventListener('input', updateSubmitState);
    document.querySelector('[name="email"]').addEventListener('input', updateSubmitState);
    document.querySelector('[name="password"]').addEventListener('input', updateSubmitState);
    document.querySelector('[name="confirm-password"]').addEventListener('input', updateSubmitState);

    checkbox.addEventListener('change', updateSubmitState);

    document.getElementById('submit-registration').addEventListener('click', async () => {

        const name = document.querySelector('[name="name"]').value;
        const email = document.querySelector('[name="email"]').value;
        const password = document.querySelector('[name="password"]').value;
        const confirmPassword = document.querySelector('[name="confirm-password"]').value;

        if (name.length < 5) {
            warningText.textContent = "* Username must have at least 5 characters *";
            return;
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(email)) {
            warningText.textContent = "* Please enter a valid email *";
            return;
        }

        if (!meetsRequirements) {
            warningText.textContent = "* Password requirement wasn't met *";
            return;
        }

        if (confirmPassword !== password) {
            warningText.textContent = "* Confirmation password is incorrect *";
            return;
        }

        // show spinner before server calls
        setSubmitLoading(true);

        const emailExists = await fetch(`/api/auth/check-email?email=${email}`).then(r => r.json());
        if (emailExists) {
            warningText.textContent = "* Email already exists *";
            setSubmitLoading(false);
            return;
        }

        const usernameExists = await fetch(`/api/auth/check-username?name=${name}`).then(r => r.json());
        if (usernameExists) {
            warningText.textContent = "* Username already exists *";
            setSubmitLoading(false);
            return;
        }

        const sendCodeRes = await fetch(`/api/auth/send-code?email=${email}&purpose=registration`, {
            method: 'POST'
        });

        const sendCodeData = await sendCodeRes.text();

        // HARD FAILURE
        if (sendCodeData === "FAILED") {
            warningText.textContent = "* Failed to send verification code *";
            setSubmitLoading(false);
            return;
        }

        userData = { name, email, password };
        warningText.textContent = "";

        // Resets the confirm form
        codeBoxes.forEach(box => box.value = '');
        confirmWarningText.textContent = '';
        updateConfirmState();

        await showConfirmation(email);
    });

    // ------------------------
    // RESEND BUTTON
    // ------------------------
    document.getElementById('resend-button').addEventListener('click', async () => {
        const resendButton = document.getElementById('resend-button');

        // show spinner immediately
        resendButton.disabled = true;
        resendButton.style.opacity = '0.4';
        resendButton.style.cursor = 'not-allowed';
        resendButton.innerHTML = '<span class="spinner"></span>';

        const resend = await fetch(`/api/auth/resend-code?email=${userData.email}&purpose=registration`, {
            method: 'POST'
        });

        if (resend.status === 429) {
            const seconds = await resend.text();
            startResendTimer(Number(seconds));
            return;
        }

        if (!resend.ok) {
            confirmWarningText.textContent = "* Failed to resend code *";
            resendButton.disabled = false;
            resendButton.style.opacity = '1';
            resendButton.style.cursor = 'pointer';
            resendButton.textContent = 'RESEND CODE';
            return;
        }

        codeBoxes.forEach(box => box.value = '');
        codeBoxes[0].focus();
        confirmWarningText.textContent = "* Code resent! *";
        startResendTimer(60);
    });

    // ------------------------
    // CONFIRM BUTTON
    // ------------------------
    const confirmButton = document.getElementById('confirm-button');
    let verificationSuccess = false;

    function updateConfirmState() {
        const code = Array.from(codeBoxes).map(b => b.value).join('');
        confirmButton.disabled = code.length !== 6;
    }

    function setConfirmLoading(IsLoading){
        if (IsLoading){
            confirmButton.disabled = true;
            confirmButton.innerHTML = '<span class="spinner"></span>';
        }else{
            confirmButton.disabled = false;
            confirmButton.innerHTML = 'CONFIRM →';
            updateConfirmState();
        }

    }

    confirmButton.addEventListener('click', async () => {
        setConfirmLoading(true);

        const code = Array.from(codeBoxes).map(box => box.value).join('');

        if (code.length < 6) {
            confirmWarningText.textContent = "* Please enter the full 6-digit code *";
            setConfirmLoading(false);
            updateConfirmState();
            return;
        }

        const verifyRes = await fetch(`/api/auth/verify-code?email=${userData.email}&code=${code}&purpose=registration`, { method: 'POST' });
        const verifyData = (await verifyRes.text()).trim();

        console.log("STATUS:", verifyRes.status);
        console.log("BODY:", verifyData);

        switch(verifyRes.status){
            case 410:
                confirmWarningText.textContent = "* Code expired, please register again *";
                setTimeout(() => {
                    const reg = document.getElementById('registration-section');
                    const conf = document.getElementById('confirmation-section');
                    fadeTo(conf, reg);

                    resetRegistrationUI();
                }, 2000);
                return;
            
            case 404:
                confirmWarningText.textContent = "* Code missing, please register again *";
                setTimeout(() => {
                    const reg = document.getElementById('registration-section');
                    const conf = document.getElementById('confirmation-section');
                    fadeTo(conf, reg);

                    resetRegistrationUI();
                }, 2000);
                return;

            case 400:
                confirmWarningText.textContent = "* Invalid code 1*";
                setConfirmLoading(false);
                return;
        }

        // INVALID
        if (!verifyRes.ok) {
            confirmWarningText.textContent = "* Invalid code 2*";
            setConfirmLoading(false);
            return;
        }

        // register
        const registerRes = await fetch('/api/auth/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(userData)
        });

        const registerData = await registerRes.json();

        // Check first if registration is success
        if (!registerData) {
            confirmWarningText.textContent = "* Registering Error *";
            return;
        }
 
        const loginRes = await fetch('/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                username: userData.email,
                password: userData.password
            })
        });

        if (!loginRes.ok) {
            confirmWarningText.textContent = "* Login failed, please sign in manually *";
            return;
        }

        await fetch(`/api/auth/complete-verification?email=${userData.email}&purpose=registration`, {
            method: 'POST'
        });

        verificationSuccess = true;
        showSuccess();
    });

    // ------------------------
    // RETURN BUTTON
    // ------------------------
    document.getElementById('return-button').addEventListener('click', () => {
        if (resendTimerInterval) clearInterval(resendTimerInterval);
        const reg = document.getElementById('registration-section');
        const conf = document.getElementById('confirmation-section');

        resetRegistrationUI();
        setSubmitLoading(false);
        fadeTo(conf, reg);
    });

    // ------------------------
    // CODE BOXES
    // ------------------------
    const codeBoxes = document.querySelectorAll('.code-box');

    codeBoxes.forEach((box, index) => {
        box.addEventListener('keydown', (e) => {

            // For user pressing enter
            if (e.key === 'Enter') {

                const allFilled = Array.from(codeBoxes).every(b => b.value !== '');
                const code = Array.from(codeBoxes).map(b => b.value).join('');

                if (allFilled && code.length === 6 && !confirmButton.disabled) {
                    e.preventDefault();
                    confirmButton.click();
                }

                return;
            }
            if ((e.ctrlKey || e.metaKey) && e.key === 'v') return;

            if (e.key === 'Backspace') {
                if (box.value) {
                    box.value = '';
                } else if (index > 0) {
                    codeBoxes[index - 1].focus();
                    codeBoxes[index - 1].value = '';
                }
                
                updateConfirmState();
                e.preventDefault();
                return;
            }

            const allowedKeys = ['Backspace', 'Delete', 'Tab', 'ArrowLeft', 'ArrowRight'];

            if (allowedKeys.includes(e.key)) {
                return;
            }

            // block function keys (F1–F12)
            if (!/^[0-9]$/.test(e.key)) {
                e.preventDefault();
                return;
            }

            box.value = e.key;
            updateConfirmState();

            if (index < codeBoxes.length - 1) codeBoxes[index + 1].focus();
            e.preventDefault();
        });

        box.addEventListener('paste', (e) => {
            e.preventDefault();
            const pasted = e.clipboardData.getData('text').replace(/[^0-9]/g, '').slice(0, 6);
            pasted.split('').forEach((char, i) => {
                if (codeBoxes[i]) codeBoxes[i].value = char;
            });
            codeBoxes[Math.min(pasted.length - 1, 5)].focus();
            updateConfirmState();
        });
    });

    function showSuccess() {
         if (!verificationSuccess) return;

        const conf = document.getElementById('confirmation-section');
        const success = document.getElementById('success-display-section');
        fadeTo(conf, success);

        let count = 5;
        const countdown = document.getElementById('redirect-countdown');

        const countInterval = setInterval(() => {
            count--;
            countdown.textContent = count;
            if (count <= 0) {
                clearInterval(countInterval);
                window.location.href = '/';
            }
        }, 1000);
    }
}