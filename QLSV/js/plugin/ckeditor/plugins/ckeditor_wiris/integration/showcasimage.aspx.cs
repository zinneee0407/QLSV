﻿using System;
using System.Web.UI;
using com.wiris.plugin.factory;
using System.Collections.Generic;
using com.wiris.plugin.api;
using com.wiris.system.service;
using com.wiris.plugin.configuration;

namespace plugin_web
{
    public partial class showcasimage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PluginBuilder pb = PluginBuilderFactory.newPluginBuilder(Request, Response);
            ParamsProvider provider = pb.getCustomParamsProvider();
            String formula = provider.getRequiredParameter("formula");
            
            // Adding - if necessary - CORS headers
            HttpResponse res = new HttpResponse(this.Response);
            String origin = this.Request.Headers.Get("origin");
            pb.addCorsHeaders(res, origin);

            byte[] bs = pb.newCas().showCasImage(formula, provider);
            Response.ContentType = "image/png";
            Response.OutputStream.Write(bs, 0, bs.Length);
        }

        override protected void OnInit(EventArgs e)
        {
            this.Load += new System.EventHandler(this.Page_Load);
            base.OnInit(e);
        }

    }
}
