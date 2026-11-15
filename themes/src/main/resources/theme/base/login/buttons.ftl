<#-- Wrap related actions with <@buttons.actionGroup horizontal=true>; group=false omits the field-group wrapper;
     layoutClass names a theme property that replaces the horizontal or vertical layout class of this group. -->
<#macro actionGroup horizontal=false id="" group=true layoutClass="">
  <#if group><div class="${properties.kcFormGroupClass!}"></#if>
    <div<#if id?has_content> id="${id}"</#if> class="${properties.kcFormActionGroupClass!(properties.kcFormButtonsClass!'')}<#if layoutClass?has_content && properties[layoutClass]??> ${properties[layoutClass]}<#elseif horizontal> ${properties.kcFormActionGroupHorizontalClass!}<#else> ${properties.kcFormActionGroupVerticalClass!}</#if>">
      <#nested>
    </div>
  <#if group></div></#if>
</#macro>

<#-- Use <@buttons.button label="doContinue"/>; type selects the style, and extra attributes are forwarded. -->
<#macro button label id="" name="" type="primary" fullWidth=true class=[] className="" labelText="" attributes={} extra...>
  <#local variantClass = properties['kcButton' + type?cap_first + 'Class']!>
  <#if type == "secondary" && !properties.kcButtonSecondaryClass??>
    <#local variantClass = properties.kcButtonDefaultClass!>
  </#if>
  <button class="${properties.kcButtonClass!} ${variantClass}<#if fullWidth> ${properties.kcButtonBlockClass!}</#if><#list class as c> ${properties[c]!}</#list><#if className?has_content> ${className}</#if>"<#if name?has_content> name="${name}"</#if><#if id?has_content> id="${id}"</#if>
          type="submit" <#list attributes as attrName, attrVal>${attrName}="${attrVal}" </#list><#list extra as attrName, attrVal>${attrName}="${attrVal}" </#list>>
  <#if labelText?has_content>${labelText}<#else>${msg(label)}</#if>
  </button>
</#macro>

<#-- Use <@buttons.buttonLink href=url.loginUrl label="backToLogin"/>; class lists theme-property names. -->
<#macro buttonLink href label id="" class=["kcButtonSecondaryClass", "kcButtonBlockClass"]>
  <a<#if id?has_content> id="${id}"</#if> href="${href}" class="${properties.kcButtonClass!}<#list class as c> <#if c == "kcButtonSecondaryClass">${properties[c]!(properties.kcButtonDefaultClass!'')}<#else>${properties[c]!}</#if></#list>">${msg(label)}</a>
</#macro>

<#-- Use <@buttons.loginButton/> for the standard login action and its action-group wrapper. -->
<#macro loginButton>
  <@buttons.actionGroup id="kc-form-buttons" layoutClass="kcLoginActionGroupClass">
    <@buttons.button id="kc-login" name="login" label="doLogIn" />
    <#if kcPasskeyButtonInActionGroup?? && enableWebAuthnConditionalUI?has_content>
      <#global kcPasskeyButtonRendered = true>
      <button id="authenticateWebAuthnButton" type="button" class="${properties.kcButtonClass!} ${properties.kcButtonSecondaryClass!(properties.kcButtonDefaultClass!'')} ${properties.kcButtonBlockClass!}">${msg("webauthn-doAuthenticate")}</button>
    </#if>
    <@buttons.tryAnotherWay/>
    <@buttons.switchOrganization/>
  </@buttons.actionGroup>
</#macro>

<#-- Use <@buttons.tryAnotherWay/> inside an action group to show the flow's "Try another way" action with the page's buttons. -->
<#macro tryAnotherWay>
  <#if kcLoginActionForms?? && auth?has_content && auth.showTryAnotherWayLink()>
    <#global kcTryAnotherWayRendered = true>
    <button id="try-another-way" type="button" onclick="document.forms['kc-select-try-another-way-form'].requestSubmit()" class="${properties.kcButtonClass!} ${properties.kcButtonSecondaryClass!(properties.kcButtonDefaultClass!'')} ${properties.kcButtonBlockClass!}">${msg("doTryAnotherWay")}</button>
  </#if>
</#macro>

<#-- Use <@buttons.switchOrganization/> inside an action group to show the flow's "Switch organization" action with the page's buttons. -->
<#macro switchOrganization>
  <#if kcLoginActionForms?? && switchOrganizationEnabled?? && switchOrganizationEnabled>
    <#global kcSwitchOrganizationRendered = true>
    <button id="switch-organization" type="button" onclick="document.forms['kc-switch-organization-form'].requestSubmit()" class="${properties.kcButtonClass!} ${properties.kcButtonSecondaryClass!(properties.kcButtonDefaultClass!'')} ${properties.kcButtonBlockClass!}">${msg("doSwitchOrganization")}</button>
  </#if>
</#macro>
