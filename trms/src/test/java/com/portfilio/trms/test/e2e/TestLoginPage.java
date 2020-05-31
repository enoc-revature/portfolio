package com.portfilio.trms.test.e2e;

import static org.junit.Assert.*;

import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Paths;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

/**
 * Used to test if page exists.  The class goes to the endpoint and tries to read the title tag.
 * Class variables WebDriver wd.
 * @author enocs
 */
public class TestLoginPage {
	WebDriver wd;
	static final String TEST_DIRECTORY = System.getenv("TEST_INPUT") + "trms\\";
	static String BASE_URL;
	static List<String> loginCredList;

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

		try {
			Paths.get(TEST_DIRECTORY + "base_url.txt");
			loginCredList = Files.readAllLines(Paths.get(TEST_DIRECTORY + "login.txt"));
		} catch(NoSuchFileException e) {
			e.getMessage();
			e.getReason();
			e.printStackTrace();
		}

		System.setProperty("webdriver.chrome.driver",System.getenv("CHROMEDRIVER_PATH") + "chromedriver.exe");
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {
		wd = new ChromeDriver();
		wd.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		wd.get(BASE_URL + "login.html");
	}

	@After
	public void tearDown() throws Exception {
		wd.close();
	}

	@Test
	public void checkIfPageExists() {
		WebElement h1 = wd.findElement(By.xpath("/html/body/h1"));
		String s = h1.getAttribute("innerHTML");
		assertTrue("Login Page Exists" ,s.equals("Login"));
	}
	
	@Test
	public void LoginSucceedsToWorkerPage() {
//		WebElement elem = wd.findElement(By.id("bencoTBodyId"));
		try {
			
		System.out.println(wd.findElement(By.id("bencoTBodyId")));
		} catch (NoSuchElementException e) {
			fail("tbody element does not exist.");
		}
//		assertTrue("Employee Login Success", elem.size()>0);
	}

	@Test
	public void LoginSucceedsToBencoPage() {
		
	}

	@Test
	public void LoginFails() {
		
	}
}
