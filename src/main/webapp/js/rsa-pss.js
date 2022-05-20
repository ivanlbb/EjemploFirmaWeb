(() => {

  /*
  Store the calculated signature here, so we can verify it later.
  */
  let signature;

  /*
  Fetch the contents of the "message" textbox, and encode it
  in a form we can use for sign operation.
  */
  function getMessageEncoding() {
    const nombre = document.querySelector("#rsa-pss-nombre");
    const documento = document.querySelector("#rsa-pss-documento");
    let message = nombre.value+"#"+documento.value;
    let enc = new TextEncoder();    
    return enc.encode(message);
  }

  /*
  Get the encoded message-to-sign, sign it and display a representation
  of the first part of it in the "signature" element.
  */
  async function signMessage(privateKey) {
	  
    const signatureValue = document.querySelector(".rsa-pss .signature-value");
    signatureValue.classList.remove("valid", "invalid");

    let encoded = getMessageEncoding();
    signature = await window.crypto.subtle.sign(
      {
        name: "RSA-PSS",
        saltLength: 32,
      },
      privateKey,
      encoded
    );

    signatureValue.classList.add('fade-in');
    signatureValue.addEventListener('animationend', () => {
      signatureValue.classList.remove('fade-in');
    });
    let buffer = new Uint8Array(signature, 0, 5);
    signatureValue.textContent = `${buffer}...[${signature.byteLength} bytes total]`;
    const parametroHidden = document.querySelector(".rsa-pss .campo-hidden")
    
    //buffer = new Uint8Array(signature, 0, 5);
    var firma =  btoa(String.fromCharCode(...new Uint8Array(signature)))
    
    console.log(firma);
    parametroHidden.value = firma;
  }

  /*
  Fetch the encoded message-to-sign and verify it against the stored signature.
  * If it checks out, set the "valid" class on the signature.
  * Otherwise set the "invalid" class.
  */
  async function verifyMessage(publicKey) {
    const signatureValue = document.querySelector(".rsa-pss .signature-value");
    signatureValue.classList.remove("valid", "invalid");

    let encoded = getMessageEncoding();
    let result = await window.crypto.subtle.verify(
      {
        name: "RSA-PSS",
        saltLength: 32,
      },
      publicKey,
      signature,
      encoded
    );

    signatureValue.classList.add(result ? "valid" : "invalid");
  }

/*
Export the given key and write it into the "exported-key" space.
*/
async function exportCryptoKey(keyPair) {
  
  const exportedPublic = await window.crypto.subtle.exportKey(
    "spki",
    keyPair.publicKey
  ); 
  
  const exportedKeyBufferPublic = new Uint8Array(exportedPublic);
  console.log(exportedKeyBufferPublic);
  
    const exportedAsString = ab2str(exportedPublic);
    const exportedAsBase64 = window.btoa(exportedAsString);
    //const pemExported = `-----BEGIN PUBLIC KEY-----\n${exportedAsBase64}\n-----END PUBLIC KEY-----`;
    const pemExported = `${exportedAsBase64}`;
    //console.log(pemExported);
    const parametroHidden = document.querySelector(".rsa-pss .clave-hidden")
    parametroHidden.value = pemExported;
    
    //submit del formulario aqui para que de tiempo a exportar la clave publica
    window.document.forms[0].submit();
}

  function ab2str(buf) {
    return String.fromCharCode.apply(null, new Uint8Array(buf));
  }

  /*
  Generate a sign/verify key, then set up event listeners
  on the "Sign" and "Verify" buttons.
  */
  window.crypto.subtle.generateKey(
    {
      name: "RSA-PSS",
      // Consider using a 4096-bit key for systems that require long-term security
      modulusLength: 2048,
      publicExponent: new Uint8Array([1, 0, 1]),
      hash: "SHA-256",
    },
    true,
    ["sign", "verify"]
  ).then((keyPair) => {
	const exportButton = document.querySelector(".rsa-pss .exportar-button");
	exportButton.addEventListener("click", () => {
		exportCryptoKey(keyPair);
	});
	  
    const signButton = document.querySelector(".rsa-pss .sign-button");
    signButton.addEventListener("click", () => {
      signMessage(keyPair.privateKey);
    });

    const verifyButton = document.querySelector(".rsa-pss .verify-button");
    verifyButton.addEventListener("click", () => {
      verifyMessage(keyPair.publicKey);
    });
	
  });

  

})();
