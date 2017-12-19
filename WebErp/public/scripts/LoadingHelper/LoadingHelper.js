
//  ACTi Corporation Copyright © 2016 All Right Reserved.
//  Author : Andy.Hsu
//  Create date : 2016-10-20
//  Description : 
//      A loader show in middle of screen.
//  Update: 20171101
//

(function (window) {
    "use strict";
    
    window.LoadingHelper = window.LoadingHelper || {};
    // initial UI element
    var loading = window.LoadingHelper;
    var loadingCount = 0;
    var loadingPanel = document.createElement("div");// full screen panel
    var loaderBackground = document.createElement("div");// Loader background area
    var loader = document.createElement("div");// loader
    loadingPanel.className = "loading-ui-vertical-center animated fadeIn fast";
    loadingPanel.isHide = true;
    loaderBackground.className = "loading-ui-loader-bg";
    loader.className = "loading-ui-loader";
    loadingPanel.appendChild(loaderBackground);
    loaderBackground.appendChild(loader);

    // Loading config template, change it if you want to change the default value.
    loading.DefaultConfig = {
        modal: false,
        message: "",
        loaderBackground:true
    };
    // Methods
    
    loading.showLoading = function (config) {
        if (config) {
            var defaultCopy = $.extend(true, {}, loading.defaultValue);
            config = $.extend(true, defaultCopy, config);
        } else {
            config = loading.DefaultConfig;
        }
        // Integrate with ACTi mobile
        if (window.MAS && MAS.IsMobile() && window.AndroidShowLoading) {
            AndroidShowLoading(config.message);
            return;
        }
        if (config.modal == true) {
            loadingPanel.className = "loading-ui-vertical-center modal divMessageBox animated fadeIn fast";
        } else {
            loadingPanel.className = "loading-ui-vertical-center animated fadeIn fast";
        }
        if (config.loaderBackground == true) {
            loaderBackground.className = "loading-ui-loader-bg dark";
        } else {
            loaderBackground.className = "loading-ui-loader-bg";
        }
        loadingCount++;
        if (loadingPanel.isHide == true) {
            loadingPanel.isHide = null;
            document.getElementsByTagName("body")[0].appendChild(loadingPanel);
        }
        
    };

    loading.hideLoading = function () {
        // Integrate with ACTi mobile
        if (window.MAS && MAS.IsMobile() && window.AndroidShowLoading) {
            AndroidHideLoading();
            return;
        }
        if (--loadingCount <= 0) {
            loading.hideAllLoading();
        }
    };
    
    loading.hideAllLoading = function () {
        // Integrate with ACTi mobile
        if (window.MAS && MAS.IsMobile() && window.AndroidShowLoading) {
            AndroidHideLoading();
            return;
        }
        if (loadingPanel.isHide == true) {
            loadingCount = 0;
            return;
        }
        loadingCount = 0;
        loadingPanel.isHide = true;
        $(loadingPanel).removeClass("fadeIn").addClass("fadeOut");//animation
        setTimeout(function () {
            if (loadingCount == 0) {
                $(loadingPanel).remove();
            }
        }, 500);
    };

})(window);
