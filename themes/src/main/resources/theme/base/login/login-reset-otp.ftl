<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>
<#import "otp-credential.ftl" as otpCredentialCard>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-reset-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
              method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <p id="kc-otp-reset-form-description">${msg("otp-reset-description")}</p>

                    <div class="${properties.kcOtpCredentialListClass!} kc-otp-credential-selection" role="radiogroup" aria-labelledby="kc-otp-reset-form-description">
                        <@otpCredentialCard.cards credentials=configuredOtpCredentials.userOtpCredentials selectedId=configuredOtpCredentials.selectedCredentialId!'' />
                    </div>

                    <div class="${properties.kcFormGroupClass!}">
                        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                            <@buttons.button id="kc-otp-reset-form-submit" label="doSubmit" class=["kcButtonLargeClass"] value=msg("doSubmit") />
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
