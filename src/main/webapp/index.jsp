<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Web Crypto API example</title>
    <link rel="stylesheet" href="css/style.css">
  </head>

  <body>

    <main>
      <h1>Web Crypto: firma/verificación</h1>
<!--       <h2>Exportar public key</h2> -->

      <section class="description">
        <p>This page shows the use of the <code>sign()</code> and <code>verify()</code> functions of the <a href="https://developer.mozilla.org/en-US/docs/Web/API/Web_Crypto_API">Web Crypto API</a>. It contains four separate examples, one for each signing algorithm supported:</p>
        <ul>
          <li>"RSA-PSS"</li>
        </ul>
        <hr/>
        <p>Cada vez que se carga la página se generan un par de claves. Al hacer submit del formulario, se envían la clave pública, el texto firmado y el valor de la firma para poder verificar la misma.</p>
<!--         <p>Each example has four components:</p> -->
<!--         <ul> -->
<!--           <li>A text box containing a message to sign.</li> -->
<!--           <li>A representation of the signature.</li> -->
<!--           <li>A "Sign" button: this signs the text box contents, displays part of the signature, and stores the complete signature.</li> -->
<!--           <li>A "Verify" button: this verifies the text box contents against the stored signature, and styles the displayed signature according to the result.</li> -->
<!--         </ul> -->
<!--         <p>Try it:</p> -->
<!--         <ul> -->
<!--           <li>Press "Sign". The signature should appear.</li> -->
<!--           <li>Press "Verify". The signature should be styled as valid.</li> -->
<!--           <li>Edit the text box contents.</li> -->
<!--           <li>Press "Verify". The signature should be styled as invalid.</li> -->
<!--         </ul> -->
      </section>

      <section class="examples">
      
<!--         <section class="sign-verify rsassa-pkcs1"> -->
<!--           <h2 class="sign-verify-heading">RSASSA-PKCS1-v1_5</h2> -->
<!--           <section class="sign-verify-controls"> -->
<!--             <div class="message-control"> -->
<!--               <label for="rsassa-pkcs1-message">Enter a message to sign:</label> -->
<!--               <input type="text" id="rsassa-pkcs1-message" name="message" size="25" -->
<!--                      value="The owl hoots at midnight"> -->
<!--             </div> -->
<!--             <div class="signature">Signature:<span class="signature-value"></span></div> -->
<!--             <input class="sign-button" type="button" value="Sign"> -->
<!--             <input class="verify-button" type="button" value="Verify"> -->
<!--           </section> -->
<!--         </section> -->
  <form id="verficar-form" action="ServletFirmaWeb" method="post" accept-charset="utf-8"  class="formulario" >
        <section class="sign-verify rsa-pss">
              

          <h2 class="sign-verify-heading">RSA-PSS</h2>
          <section class="sign-verify-controls">
            <div class="message-control-nombre">
              <label for="rsa-pss-nombre">Nombre:</label>
              <input type="text" id="rsa-pss-nombre" name="nombre" size="25"
                     value="Nombre">
                     
            </div>
            <div class="message-control-documento">
              <label for="rsa-pss-documento">Documento:</label>
              <input type="text" id="rsa-pss-documento" name="documento" size="25"
                     value="Documento">
                     
            </div>
            
            <input type="hidden" class="campo-hidden" name="valor-firma">
            <input type="hidden" class="clave-hidden" name="clave-publica">
            <div class="signature">Signature:<span class="signature-value"></span></div>
            <input class="sign-button" type="button" value="Firmar">
            <input class="verify-button" type="button" value="Verificar">
			<input class="exportar-button" type="button" value="Submit">
          </section>
        </section>
  </form>
<!--         <section class="sign-verify ecdsa"> -->
<!--           <h2 class="sign-verify-heading">ECDSA</h2> -->
<!--           <section class="sign-verify-controls"> -->
<!--             <div class="message-control"> -->
<!--               <label for="ecdsa-message">Enter a message to sign:</label> -->
<!--               <input type="text" id="ecdsa-message" name="message" size="25" -->
<!--                      value="The eagle flies at twilight"> -->
<!--             </div> -->
<!--             <div class="signature">Signature:<span class="signature-value"></span></div> -->
<!--             <input class="sign-button" type="button" value="Sign"> -->
<!--             <input class="verify-button" type="button" value="Verify"> -->
<!--           </section> -->
<!--         </section> -->
<!--         <section class="sign-verify hmac"> -->
<!--           <h2 class="sign-verify-heading">HMAC</h2> -->
<!--           <section class="sign-verify-controls"> -->
<!--             <div class="message-control"> -->
<!--               <label for="hmac-message">Enter a message to sign:</label> -->
<!--               <input type="text" id="hmac-message" name="message" size="25" -->
<!--                      value="The bunny hops at teatime"> -->
<!--             </div> -->
<!--             <div class="signature">Signature:<span class="signature-value"></span></div> -->
<!--             <input class="sign-button" type="button" value="Sign"> -->
<!--             <input class="verify-button" type="button" value="Verify"> -->
<!--           </section> -->
<!--         </section> -->
      </section>
    </main>
  
  </body>

<!--   <script src="rsassa-pkcs1.js"></script> -->
  <script src="js/rsa-pss.js"></script>
<!--   <script src="js/ecdsa.js"></script> -->
<!--   <script src="hmac.js"></script> -->
</html>
