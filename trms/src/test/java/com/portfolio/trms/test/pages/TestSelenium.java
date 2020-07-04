package com.portfolio.trms.test.pages;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
//import org.openqa.selenium.firefox.FirefoxDriver;

/**
 * Code smells are kept for reference.
 * This class is kept for code snippets.
 * @author enocs
 * @deprecated
 */
public class TestSelenium {

	public static void main(String[] args) {
		
		// 1) Set up the driver executable
		System.setProperty("webdriver.chrome.driver",System.getenv("CHROMEDRIVER_PATH") + "chromedriver.exe");

		/* 2) Initialize your chromedriver
		 * Available Drivers:
		 * ChromeDriver
		 * FirefoxDriver
		 * InternetExplorerDriver
		 * AndroidDriver
		 * IphoneDriver
		 * HtmlUnitDriver
		 */
		WebDriver wd = new ChromeDriver();
//		WebDriver wd = new FirefoxDriver();
		
		// 3) Apply a wait-time
		wd.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		
		// 4) Maximize window
		//wd.manage().window().maximize();
		
		// 5) Open browser to a URL
//		wd.get("https://www.microsoft.com");
//		wd.get("https://localhost:8080");
		wd.get("http://localhost:4200");
//		wd.get("https://www.stackexchange.com");
//		wd.navigate().to("http://sqa.stackexchange.com");
		
		// Assertion
		WebElement h1 = wd.findElement(By.id("data-form-headerId"));
		String s = h1.getAttribute("innerHTML");
		System.out.println("Found h1 element: " + s.equals("Credit Loan Form"));

//		WebElement h1 = wd.findElement(By.xpath("/html/head/title"));
//		String s = h1.getAttribute("innerHTML");
//		System.out.println("Found title element: " + s.equals("Microsoft - Official Home Page"));

		// 6) Close Browser
		wd.close();
		System.out.println("Finished");
	}

}



