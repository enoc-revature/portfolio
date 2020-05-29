package com.portfilio.trms.test.e2e;

import static org.junit.Assert.*;

import java.util.concurrent.TimeUnit;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

/**
 * Used to test if page exists.  The class goes to the endpoint and tries to read the title tag.
 * Class variables WebDriver wd.
 * @author enocs
 */
public class BasePageExists {
	WebDriver wd = null;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		System.setProperty("webdriver.chrome.driver",System.getenv("CHROMEDRIVER_PATH") + "chromedriver.exe");
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		wd = new ChromeDriver();
		wd.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
	}

	@After
	public void tearDown() throws Exception {
		wd.close();
	}

	@Test
	public void checkIfPageExists() {
//		wd.get("http://localhost:8080");
		wd.get("http://localhost:4200"); // This is the wrong app.  I'm just testing for now.
		WebElement h1 = wd.findElement(By.id("data-form-headerId"));
		String s = h1.getAttribute("innerHTML");
		assertTrue(s.equals("Credit Loan Form"));

	}

}
