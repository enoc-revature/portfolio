package com.portfolio.trms.test.pages;

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
import org.junit.Ignore;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

/**
 * This test suite checks if its able to reach the endpoint and checks one login.  
 * Exhaustive tests are performed on the dev version: DevLoginPage.
 * @author enocs
 */
public class TestLoginPage {
	protected WebDriver wd;
	protected static final String TEST_DIRECTORY = System.getenv("TEST_INPUT") + "trms/";
	protected static String BASE_URL;
	protected static List<String> loginCredList;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		try {
			Paths.get(TEST_DIRECTORY + "base_url.txt");
			BASE_URL = Files.readAllLines(Paths.get(TEST_DIRECTORY + "base_url.txt")).get(0);
			loginCredList = Files.readAllLines(Paths.get(TEST_DIRECTORY + "reimbursement_form_test_cases/allValidNoOptional.txt"));
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

		System.setProperty("webdriver.chrome.driver",System.getenv("CHROME_DRIVER"));
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
		WebElement elem = null;
		WebElement usernameField = null;
		WebElement passwordField = null;
		WebElement loginBtn = null;

		try {
			usernameField = wd.findElement(By.id("empId"));
		} catch (NoSuchElementException e) {
			fail("Username <input> element does not exist.");
		}

		try {
			passwordField = wd.findElement(By.id("pwId"));
		} catch (NoSuchElementException e) {
			fail("Password <input> element does not exist.");
		}

		try {
			loginBtn = wd.findElement(By.id("submitId"));
		} catch (NoSuchElementException e) {
			fail("Login <button> element does not exist.");
		}

		usernameField.clear();
		passwordField.clear();

		usernameField.sendKeys(loginCredList.get(0));
		passwordField.sendKeys(loginCredList.get(1));
		loginBtn.click();

		try {
			elem = wd.findElement(By.id("myReimbursementsId"));
		} catch (NoSuchElementException e) {
			fail("<div> element does not exist.");
		}
		assertEquals("div", elem.getTagName());
	}
}
