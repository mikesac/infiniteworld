package org.infinite.util;

import java.awt.Graphics;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.HeadlessException;
import java.awt.Image;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.infinite.objects.Map;

public class ImageUtil {

	
	public static BufferedImage prepareMapStripes(InputStream is,int nx,int ny,String path) throws IOException{
		
		BufferedImage img =  ImageIO.read(is);
		
		//first scale
		BufferedImage scaledImg = toBufferedImage(img.getScaledInstance(Map.MAP_WIDTH, Map.MAP_HEIGHT, Image.SCALE_SMOOTH) );
		
		int w = Map.MAP_WIDTH/nx;
		int h = Map.MAP_HEIGHT/ny;
		
		for (int i = 0; i < ny; i++) {
			for (int j = 0; j < nx; j++) {
				
				int x = w*j;
				int y = h*i;
				BufferedImage crop = scaledImg.getSubimage(x, y, w, h);
				
				File f = new File(path+"/crop_"+i+j+".jpg");
				ImageIO.write(crop, "jpg", f);
			}
		}
		
				
		return null;
	}
	
	
	

	 public static BufferedImage toBufferedImage(Image image) {

	        if (image instanceof BufferedImage) {return (BufferedImage)image;}	   

	        // This code ensures that all the pixels in the image are loaded
	        image = new ImageIcon(image).getImage();
   
	        // Determine if the image has transparent pixels
	        boolean hasAlpha = false;//hasAlpha(image);

	        // Create a buffered image with a format that's compatible with the screen
	        BufferedImage bimage = null;
	        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();

	        try {

	            // Determine the type of transparency of the new buffered image
	            int transparency = Transparency.OPAQUE;
	            if (hasAlpha == true) {transparency = Transparency.BITMASK;}
  
	            // Create the buffered image
	            GraphicsDevice gs = ge.getDefaultScreenDevice();
	            GraphicsConfiguration gc = gs.getDefaultConfiguration();
	            bimage = gc.createCompatibleImage(image.getWidth(null), image.getHeight(null), transparency);
	        }

	        catch (HeadlessException e) {e.printStackTrace();} //No screen
	   
	        if (bimage == null) {
	            // Create a buffered image using the default color model
	            int type = BufferedImage.TYPE_INT_RGB;
	            if (hasAlpha == true) {type = BufferedImage.TYPE_INT_ARGB;}
	            bimage = new BufferedImage(image.getWidth(null), image.getHeight(null), type);
	        }
   
	        // Copy image to buffered image
	        Graphics g = bimage.createGraphics();
 
	        // Paint the image onto the buffered image
	        g.drawImage(image, 0, 0, null);
	        g.dispose();
	   
	        return bimage;
	    }
 

	      public static boolean hasAlpha(Image image) {
	             // If buffered image, the color model is readily available
	             if (image instanceof BufferedImage) {return ((BufferedImage)image).getColorModel().hasAlpha();}
         
	             // Use a pixel grabber to retrieve the image's color model;
	             // grabbing a single pixel is usually sufficient
	             PixelGrabber pg = new PixelGrabber(image, 0, 0, 1, 1, false);
	             try {pg.grabPixels();} catch (InterruptedException e) {}
	         
	             // Get the image's color model
	             return pg.getColorModel().hasAlpha();
	         }

	}
