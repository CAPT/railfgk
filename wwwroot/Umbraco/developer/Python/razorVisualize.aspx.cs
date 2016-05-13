using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using prg.RazorExtensions;

public partial class umbraco_developer_Python_razorVisualize : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        Pane1.Text = "Visualize saved Razor file: " + Request["filename"];

    }
    protected void visualizeDo_Click(object sender, EventArgs e)
    {
        var nodeId = 0;
        Int32.TryParse(contentPicker.Value, out nodeId);

        var script = xsltSelection.Value;

        //var n = RenderRazor.RenderRazorScriptString(script, nodeId);
        var d = new Dictionary<string,string>();
        d.Add("VisualizeOption",visualizeOption.Text);        
        var n = RenderRazor.RenderRazorScriptFile(Request["filename"], nodeId,d);
        visualizeContainer.Visible = true;
        visualizeArea.Text = n;

        //throw new NotImplementedException();
    }
}