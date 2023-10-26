package shareex;

import android.content.Intent;
import android.net.Uri;
import org.haxe.extension.Extension;

import java.io.File;
import androidx.core.content.FileProvider;

public class ShareEx {

	public static void share(String text, String subject, String html, String email, String image) {
		Intent sendIntent = new Intent(android.content.Intent.ACTION_SEND);
		sendIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        if ( image.equals("") ) {
		    sendIntent.setType("text/plain");
        } else {
            sendIntent.setType("image/*");
            sendIntent.putExtra(Intent.EXTRA_STREAM, Uri.parse("file://" + image));
            sendIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        }

		if(subject!=null && subject!="") sendIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, subject);
		if(text!=null && text!="") sendIntent.putExtra(android.content.Intent.EXTRA_TEXT, text);
		if(html!=null && html!="") sendIntent.putExtra(android.content.Intent.EXTRA_HTML_TEXT, html);
		if(email!=null && email!="") sendIntent.putExtra(android.content.Intent.EXTRA_EMAIL, email);
		Extension.mainActivity.getApplicationContext().startActivity(sendIntent);
	}

	public static void shareImage(String fileProvider, String imageName) {
		File imageFile = new File(Extension.mainContext.getFilesDir(), imageName);
        Uri imageUri = FileProvider.getUriForFile(
                Extension.mainActivity,
                fileProvider,
                imageFile);

		Intent sendIntent = new Intent(android.content.Intent.ACTION_SEND);
		sendIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

		sendIntent.setType("image/jpg");
		sendIntent.putExtra(Intent.EXTRA_STREAM, imageUri);
    	sendIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        
		Extension.mainActivity.getApplicationContext().startActivity(sendIntent);
	}
	
	public static void sharePDF(String fileProvider, String pdfName) {
		File pdfFile = new File(Extension.mainContext.getFilesDir(), pdfName);
        Uri pdfUri = FileProvider.getUriForFile(
                Extension.mainActivity,
                fileProvider,
                pdfFile);

		Intent sendIntent = new Intent(android.content.Intent.ACTION_SEND);
		sendIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

		sendIntent.setType("application/pdf");
		sendIntent.putExtra(Intent.EXTRA_STREAM, pdfUri);
    	sendIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        
		Extension.mainActivity.getApplicationContext().startActivity(sendIntent);
	}

}
