package es.ivan;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.MGF1ParameterSpec;
import java.security.spec.PSSParameterSpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bouncycastle.jce.provider.BouncyCastleProvider;


/**
 * Servlet implementation class ServletFirmaWeb
 */
public class ServletFirmaWeb extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public ServletFirmaWeb() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Texto firmado : ").append(request.getParameter("message")).
		append("\n\nFirma: "+request.getParameter("valor-firma")).
				append("\n\nPublic Key: "+request.getParameter("clave-publica"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nombreUFTF8 = new String(request.getParameter("nombre").getBytes(), StandardCharsets.UTF_8);
		String documentoUFTF8 = new String(request.getParameter("documento").getBytes(), StandardCharsets.UTF_8);
		String textoFirmado = nombreUFTF8.concat("#").concat(documentoUFTF8);
		response.setContentType("plain");
		response.setCharacterEncoding("ISO-8859-1");
		response.getWriter().append("Texto firmado : ").append(textoFirmado).
		append("\n\nFirma: "+request.getParameter("valor-firma")).
				append("\n\nPublic Key: "+request.getParameter("clave-publica"));
		
		try {
			PublicKey rsaPublicKey = getClavePulica(request.getParameter("clave-publica"));
			
			if (verifySignaturePSS(textoFirmado, request.getParameter("valor-firma"), rsaPublicKey)) {
				response.getWriter().write("\n\nFirma válida");
			} else {
				response.getWriter().write("\n\nFirma NO válida");
			}
			
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidAlgorithmParameterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SignatureException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

    private PublicKey getClavePulica(String claveB64) throws NoSuchAlgorithmException, InvalidKeySpecException {
    	  byte[] clave = Base64.getDecoder().decode(claveB64);
		    X509EncodedKeySpec spec =
		      new X509EncodedKeySpec(clave);
		    KeyFactory kf = KeyFactory.getInstance("RSA");
		    return kf.generatePublic(spec);
   }
    
    private boolean verifySignaturePSS(String dataToVerify, String signedData, PublicKey publicKeySign) throws NoSuchAlgorithmException, NoSuchProviderException, InvalidAlgorithmParameterException, InvalidKeyException, SignatureException{
        boolean bool = false;

            Signature signature = Signature.getInstance("SHA256withRSA/PSS", new BouncyCastleProvider());
            signature.setParameter(new PSSParameterSpec("SHA-256", "MGF1", MGF1ParameterSpec.SHA256, 32, 1));
            signature.initVerify(publicKeySign);

            byte[] bSignedData = Base64.getDecoder().decode(signedData);
            //byte[] bSignedData = signedData.getBytes();
            byte[] bDataToVerify = dataToVerify.getBytes(StandardCharsets.UTF_8);//decodeBase64(dataToVerify);

            signature.update(bDataToVerify);
            bool = signature.verify(bSignedData);
        
        return bool;
    }
    
}