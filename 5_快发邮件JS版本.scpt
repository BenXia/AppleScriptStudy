JsOsaDAS1.001.00bplist00�Vscript_�
// Variablesvar recipientName="Ben";var recipientAddress="352229402@qq.com";var theSubject="AppleScript Automated Email";var theContent="This email was created and sent using AppleScript!";

// Mail Tell Block
var mailApp=Application("Mail");
// Create the message
//var newMessage=mailApp.OutgoingMessage({subject:theSubject, content:theContent, visible:true});
//mailApp.outgoingMessages.push(newMessage);

// Same as above
//var newMessage=mailApp.OutgoingMessage().make();
//newMessage.subject=theSubject;
//newMessage.content=theContent;
//newMessage.visible=true;	// Set a recipient
var newRecipient=mailApp.Recipient({name:recipientName, address:recipientAddress})
newMessage.toRecipients.push(newRecipient);
// Send the Message// newMessage.send();

var systemEventsApp=Application("System Events");
var mailProcess=systemEventsApp.processes["Mail"];
mailProcess.frontmost = true;




// --------- UI Automation ------------
//Notes = Application('Notes')
//Notes.activate()
 
//delay(1)
//SystemEvents = Application('System Events')
//Notes = SystemEvents.processes['Notes']
 
//Notes.windows[0].splitterGroups[0].groups[1].groups[0].buttons[0].click()
	                              � jscr  ��ޭ