<%@ language= "JavaScript" %>
<%

// WARNING! THIS FILE USES JSCRIPT, WHICH IS NOT QUITE JAVASCRIPT. CHECK DOCUMENTATION BEFORE MODIFYING

Response.ContentType = "application/json";

var asp       = new ASPServer(); // handles everything that isn't pure JavaScript

var sender    = "BPS Webmaster <webmaster@bentonvillek12.org>";
var recipient = "kerrca@bentonvillek12.org"; // thudson
var name      = asp.fetch("name");
var email     = asp.fetch("email");
var phone     = asp.fetch("phone");
var subject   = "Ignite Contact Request (" + name + ")";

var message   = "<h2>" + name + " filled out the Ignite contact form.</h2>" +
                    "<dl>" +
                        "<dt>Name:</dt><dd>" + name + "</dd>" +
                        "<dt>Email:</dt><dd>" + email + "</dd>" +
                        "<dt>Phone:</dt><dd>" + phone + "</dd>" +
                    "</dl>" +
                "<h3>Message:</h3>" +
                "<blockquote>" + asp.fetch("message") + "</blockquote>";

try {
    asp.sendEmail(sender, recipient, subject, message);
    asp.print('{ "message": "Thank you! Your message has been sent. Theresa Hudson (the Ignite Director) will contact you if needed." }');
} catch (e) {
    asp.print('{ "message": "Email Failed", "error": "' + e.message + '" }');
}


// Handles everything that isn't pure JavaScript
function ASPServer() {
    this.print = function(val) {
        Response.Write(val);
    };
    
    this.fetch = function(field) {
        return new String(
            Request.ServerVariables("REQUEST_METHOD") == "POST"
                ? Request.Form(field)
                : Request.QueryString(field)
        );
    };
    
    this.sendEmail = function(sender, recipient, subject, message) {
        var mail = Server.CreateObject("CDO.Message"),
            config = "http://schemas.microsoft.com/cdo/configuration/";
        mail.Configuration.Fields.Item(config + "smtpserver") = "smtp";
        mail.Configuration.Fields.Item(config + "smtpserverport") = 25;
        mail.Configuration.Fields.Item(config + "sendusing") = 2;
        mail.Configuration.Fields.Item(config + "smtpconnectiontimeout") = 60;
        mail.Configuration.Fields.Update();
        mail.From = sender;
		mail.ReplyTo = email;
        mail.To = recipient;
        mail.Subject = subject;
        mail.HTMLBody = message;
        mail.Send();
    };
}

%>