<%--
  ~ Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.lang.Boolean" %>
<%@ taglib prefix="layout" uri="org.wso2.identity.apps.taglibs.layout.controller" %>

<%@ include file="includes/localize.jsp" %>
<jsp:directive.include file="includes/layout-resolver.jsp" />

<%
    request.getSession().invalidate();
    String queryString = request.getQueryString();
    Map<String, String> idpAuthenticatorMapping = null;
    if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
        idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
    }

    String error = AuthenticationEndpointUtil.i18n(resourceBundle, "authentication.error");
    String errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle,"something.went.wrong.during.authentication");
    String authenticationFailed = "false";

    if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {
        authenticationFailed = "true";
         
        if (request.getParameter(Constants.AUTH_FAILURE_MSG) != null) {
        errorMessage = request.getParameter(Constants.AUTH_FAILURE_MSG);
        
            if (errorMessage.equalsIgnoreCase("user.not.registered")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.user.not.registered");
            } else if (errorMessage.equalsIgnoreCase("user.not.found")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.user.not.found");
            } else if (errorMessage.equalsIgnoreCase("unable.to.get.duo.mobileNumber")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.mobile.not.found.duo");
            } else if (errorMessage.equalsIgnoreCase("unable.to.find.number")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.mobile.not.found");
            } else if (errorMessage.equalsIgnoreCase("number.mismatch")) {
                errorMessage = AuthenticationEndpointUtil.i18n(resourceBundle, "error.number.mismatch.duo");
            }
        }
    }
%>

<%-- Data for the layout from the page --%>
    <% layoutData.put("containerSize", "medium" ); %>

<!doctype html>
<html lang="en-US">

<head>
    <%-- header --%>
        <% File headerFile=new File(getServletContext().getRealPath("extensions/header.jsp")); if
            (headerFile.exists()) { %>
            <jsp:include page="extensions/header.jsp" />
            <% } else { %>
                <jsp:include page="includes/header.jsp" />
                <% } %>
</head>

<body class="login-portal layout authentication-portal-layout">
    <layout:main layoutName="<%= layout %>" layoutFileRelativePath="<%= layoutFileRelativePath %>"
        data="<%= layoutData %>">
        <layout:component componentName="ProductHeader">
            <%-- product-title --%>
                <% File productTitleFile=new
                    File(getServletContext().getRealPath("extensions/product-title.jsp")); if
                    (productTitleFile.exists()) { %>
                    <jsp:include page="extensions/product-title.jsp" />
                    <% } else { %>
                        <jsp:include page="includes/product-title.jsp" />
                        <% } %>
        </layout:component>
        <layout:component componentName="MainSection">
            <div class="ui segment">
                <div class="segment-form">
                    <div class="ui visible negative message">
                        <div class="header">
                            <%=error%>
                        </div>
                        <p>
                            <%=errorMessage%>
                        </p>
                    </div>
                </div>
            </div>
        </layout:component>
        <layout:component componentName="ProductFooter">
            <%-- product-footer --%>
                <% File productFooterFile=new
                    File(getServletContext().getRealPath("extensions/product-footer.jsp")); if
                    (productFooterFile.exists()) { %>
                    <jsp:include page="extensions/product-footer.jsp" />
                    <% } else { %>
                        <jsp:include page="includes/product-footer.jsp" />
                        <% } %>
        </layout:component>
    </layout:main>

    <%-- footer --%>
        <% File footerFile=new File(getServletContext().getRealPath("extensions/footer.jsp")); if
            (footerFile.exists()) { %>
            <jsp:include page="extensions/footer.jsp" />
            <% } else { %>
                <jsp:include page="includes/footer.jsp" />
                <% } %>
</body>

</html>
