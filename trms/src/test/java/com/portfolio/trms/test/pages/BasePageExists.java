package com.portfolio.trms.test.pages;

import static org.junit.Assert.assertTrue;

import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Paths;
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
import org.openqa.selenium.chrome.ChromeOptions;

/**
 * Used to test if page exists.  The class goes to the endpoint and tries to read the title tag.
 * Class variables WebDriver wd.
 * @author enocs
 */
public class BasePageExists {
	WebDriver wd;
	static final String TEST_DIRECTORY = System.getenv("TEST_INPUT") + "trms/";
	static String BASE_URL;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		try {
			Paths.get(TEST_DIRECTORY + "base_url.txt");
			BASE_URL = Files.readAllLines(Paths.get(TEST_DIRECTORY + "base_url.txt")).get(0);
		} catch(NoSuchFileException e) {
			e.getMessage();
			e.getReason();
			e.printStackTrace();
		}
		System.setProperty("webdriver.chrome.driver",System.getenv("CHROME_DRIVER"));
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		ChromeOptions opt = new ChromeOptions();
        opt.addArguments("--headless");
        opt.addArguments("--no-sandbox");
		wd = new ChromeDriver(opt);
		wd.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
	}

	@After
	public void tearDown() throws Exception {
		wd.close();
	}

	@Test
	public void checkIfPageExists() {
		wd.get(BASE_URL + "login.html");
		WebElement h1 = wd.findElement(By.xpath("/html/body/h1"));
		String s = h1.getAttribute("innerHTML");
		assertTrue(s.equals("Login"));
	}
}
