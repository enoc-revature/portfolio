package com.portfilio.trms.test.pages;

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
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Select;

public class TestFormPage {
	protected WebDriver wd;
	protected static final String TEST_DIRECTORY = System.getenv("TEST_INPUT") + "trms\\";
	protected static String BASE_URL;
	protected static List<String> loginCredList;
	protected static List<String> formDataList;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		try {
			Paths.get(TEST_DIRECTORY + "base_url.txt");
			BASE_URL = Files.readAllLines(Paths.get(TEST_DIRECTORY + "base_url.txt")).get(0);
			formDataList = Files.readAllLines(Paths.get(TEST_DIRECTORY + "reimbursement_form_test_cases\\allValidNoOptional.txt"));
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
		wd.get(BASE_URL + "form.html");
	}

	@After
	public void tearDown() throws Exception {
		wd.close();
	}

	@Test
	public void formPageExists() {
		WebElement form = null;
		try {
			form = wd.findElement(By.id("requestFormId"));
		} catch (NoSuchElementException e) {
			fail("<form> element does not exist.");
		}
		assertTrue("Form Page Exists" ,form.getTagName().equals("form"));
	}
	
	@Test
	public void formAllValidNoOptional() {
		// Declare elements
		WebElement firstName = null;
		WebElement lastName = null;
		WebElement email = null;
		WebElement phone = null;
		WebElement empStreet = null;
		Select empState = null;
		WebElement empZip = null;
		WebElement eventDate = null;
		WebElement eventTime = null;
		WebElement eventStreet = null;
		Select eventState = null;
		WebElement eventZip = null;
		WebElement description = null;
		WebElement cost = null;
		Select gradingFormat = null;
		Select passingGrade = null;
		Select eventType = null;
		WebElement justification = null;
		WebElement submitBtn = null;

		try {
			// Check to make sure elements are obtained
			firstName = wd.findElement(By.id("firstNameId"));
			lastName = wd.findElement(By.id("lastNameId"));
			email = wd.findElement(By.id("emailId"));
			phone = wd.findElement(By.id("phoneId"));
			empStreet = wd.findElement(By.id("empStreetId"));
			empState = new Select(wd.findElement(By.id("empStateId")));
			empZip = wd.findElement(By.id("empZip"));
			eventDate = wd.findElement(By.id("dateId"));
			eventTime = wd.findElement(By.id("timeId"));
			eventStreet = wd.findElement(By.id("eventStreetId"));
			eventState = new Select(wd.findElement(By.id("eventStateId")));
			eventZip = wd.findElement(By.id("eventZipId"));
			description = wd.findElement(By.id("descriptionId"));
			cost = wd.findElement(By.id("costId"));
			gradingFormat = new Select(wd.findElement(By.id("gradingFormatId")));
			passingGrade = new Select(wd.findElement(By.id("passingGradeId")));
			eventType = new Select(wd.findElement(By.id("typeId")));
			justification = wd.findElement(By.id("justificationId"));
			submitBtn = wd.findElement(By.id("submitBtnId"));
		} catch (NoSuchElementException e) {
			fail("At leest one form elements does not exist.");
		}
		
		// Set values to elements in form
		firstName.sendKeys(formDataList.get(0));
		lastName.sendKeys(formDataList.get(1));
		email.sendKeys(formDataList.get(2));
		phone.sendKeys(formDataList.get(3));
		empStreet.sendKeys(formDataList.get(4));
		empState.selectByIndex(Integer.parseInt(formDataList.get(5)));
		empZip.sendKeys(formDataList.get(6));
		eventDate.sendKeys(formDataList.get(7));
		eventTime.sendKeys(formDataList.get(8));
		eventStreet.sendKeys(formDataList.get(9));
		eventState.selectByIndex(Integer.parseInt(formDataList.get(10)));
		eventZip.sendKeys(formDataList.get(11));
		description.sendKeys(formDataList.get(12));
		cost.sendKeys(formDataList.get(13));
		gradingFormat.selectByIndex(Integer.parseInt(formDataList.get(14)));
		passingGrade.selectByIndex(Integer.parseInt(formDataList.get(15)));
		eventType.selectByIndex(Integer.parseInt(formDataList.get(16)));
		justification.sendKeys(formDataList.get(17));
		
		// Click submit
		submitBtn.click();
		
		// HTTP status response
		
	}

}
