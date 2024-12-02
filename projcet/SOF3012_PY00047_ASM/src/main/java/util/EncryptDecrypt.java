package util;

import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class EncryptDecrypt {
    public static String ALGORITHM = "AES";
    private static String AES_CBS_PADDING = "AES/CBC/PKCS5Padding";
    private static int AES_128 = 128;


    private static byte[] encryptDecrypt(final int mode, final byte[] key, final byte[] IV, final byte[] message)
            throws Exception {
        final Cipher cipher = Cipher.getInstance(AES_CBS_PADDING);
        final SecretKeySpec keySpec = new SecretKeySpec(key, ALGORITHM);
        final IvParameterSpec ivSpec = new IvParameterSpec(IV);
        cipher.init(mode, keySpec, ivSpec);
        return cipher.doFinal(message);
    }

    public static Map<String, SecretKey> keyGenerator() throws NoSuchAlgorithmException{
        Map<String, SecretKey> map = new HashMap<String, SecretKey>();
         KeyGenerator keyGenerator = KeyGenerator.getInstance(EncryptDecrypt.ALGORITHM);
         keyGenerator.init(AES_128);
         SecretKey key = keyGenerator.generateKey();
         map.put("key", key);
         SecretKey IV = keyGenerator.generateKey();
         map.put("iv", IV);
         return map;

    }


    public static String encrypt(String message) throws Exception{
        Map<String , SecretKey> map = keyGenerator();
        SecretKey key = map.get("key");
        SecretKey IV = map.get("iv");
        byte[] cipherText = encryptDecrypt(Cipher.ENCRYPT_MODE, key.getEncoded(), IV.getEncoded(), message.getBytes());
        String encrypted_message =  Base64.getEncoder().encodeToString(cipherText);
        String encodedKey = Base64.getEncoder().encodeToString(map.get("key").getEncoded());
        String encodedIV = Base64.getEncoder().encodeToString(map.get("iv").getEncoded());

        return encrypted_message+"javax"+encodedIV+"javax"+encodedKey;



    }

    public static String decrypt(String encryptedMessage) throws Exception{
        String[] result = encryptedMessage.split("javax");
        byte[] decodedIV = Base64.getDecoder().decode(result[1]);
        byte[] decodedKey = Base64.getDecoder().decode(result[2]);
        byte[] cipher_text = Base64.getDecoder().decode(result[0]);
        SecretKey IV = new SecretKeySpec(decodedIV, 0, decodedIV.length, "AES");
        SecretKey key = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");    
        byte[] decryptedString = encryptDecrypt(Cipher.DECRYPT_MODE, key.getEncoded(), IV.getEncoded(), cipher_text);
        String decryptedMessage = new String(decryptedString);
        return decryptedMessage;

    }


    public static void main(String[] args) throws Exception {
        String encryptedmessage =  EncryptDecrypt.encrypt("user123");
        System.out.println(encryptedmessage);
        String decryptedMessage = EncryptDecrypt.decrypt("tBJhh5u2Rkcrf2Q2Qxt2sw==javaxHaWXSB5Drl40+sS9G2VHGQ==javaxB2K2IBVIgmftKpnEffrreA==");
        System.out.println(decryptedMessage);
    }

}