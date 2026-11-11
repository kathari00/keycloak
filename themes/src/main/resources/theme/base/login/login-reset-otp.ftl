<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-reset-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
              method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <p id="kc-otp-reset-form-description">${msg("otp-reset-description")}</p>

                    <div role="radiogroup" aria-labelledby="kc-otp-reset-form-description">
                        <#list configuredOtpCredentials.userOtpCredentials as otpCredential>
                            <#assign selected = otpCredential.id == configuredOtpCredentials.selectedCredentialId>
                            <label class="${properties.kcLoginOTPListClass!}<#if selected> ${properties.kcLoginOTPListSelectedClass!}</#if>">
                                <input id="kc-otp-credential-${otpCredential?index}" class="${properties.kcSrOnlyClass!}" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if selected>checked="checked"</#if>>
                                <span class="${properties.kcLoginOTPListItemHeaderClass!}">
                                    <span class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                        <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                    </span>
                                    <span class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</span>
                                </span>
                            </label>
                        </#list>
                    </div>

                    <div class="${properties.kcFormGroupClass!}">
                        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                            <@buttons.button id="kc-otp-reset-form-submit" label="doSubmit" class=["kcButtonLargeClass"] value=msg("doSubmit") />
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <script>
            <#outputformat "JavaScript">
            (() => {
                const selectedClass = ${properties.kcLoginOTPListSelectedClass!?c};
                const inputs = document.querySelectorAll('#kc-otp-reset-form input[name="selectedCredentialId"]');
                inputs.forEach(input => input.addEventListener('change', () => {
                    if (selectedClass) {
                        inputs.forEach(option => option.closest('label')?.classList.toggle(selectedClass, option.checked));
                    }
                }));
            })();
            </#outputformat>
        </script>
    </#if>
</@layout.registrationLayout>
