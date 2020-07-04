package com.portfolio.trms.test.pages;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Paths;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class TestWorkerPage {
	protected WebDriver wd;
	protected static final String TEST_DIRECTORY = System.getenv("TEST_INPUT") + "trms\\";
	protected static String BASE_URL;
	protected static List<String> loginCredList;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		try {
			Paths.get(TEST_DIRECTORY + "base_url.txt");
			BASE_URL = Files.readAllLines(Paths.get(TEST_DIRECTORY + "base_url.txt")).get(0);
			loginCredList = Files.readAllLines(Paths.get(TEST_DIRECTORY + "reimbursement_form_test_cases\\allValidNoOptional.txt"));
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
		wd.get(BASE_URL + "benco.html");
	}

	@After
	public void tearDown() throws Exception {
		wd.close();
	}

	@Test
	public void workerPageExists() {
		WebElement h1 = wd.findElement(By.xpath("/html/body/h1"));
		String s = h1.getAttribute("innerHTML");
		assertTrue("Login Page Exists" ,s.equals("Login"));
	}
	
	@Ignore
	@Test
	public void workerSessionExists() {
	}
	
	@Test
	public void workerRowClick() {
		WebElement elem = null;
		WebElement rowClick = null;

		try {
			rowClick = wd.findElement(By.id("submitId"));
		} catch (NoSuchElementException e) {
			fail("Row <tr> element does not exist.");
		}

		rowClick.click();

		try {
			elem = wd.findElement(By.xpath("/html/body/h1"));
		} catch (NoSuchElementException e) {
			fail("<h1> element does not exist.");
		}
		assertEquals("Reimbursement Details", elem.getAttribute("innerHTML"));
	}
}
