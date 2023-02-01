-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id, backers_count
FROM campaign WHERE outcome = 'live'
ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_ID, COUNT(backer_ID) AS backer_count
FROM backers
GROUP BY cf_id
ORDER BY backer_count DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT C.first_name, C.last_name, C.email, (CA.goal - CA.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts C
JOIN campaign CA
ON CA.contact_id = C.contact_id
WHERE CA.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * 
FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT B.email, B.first_name, B.last_name, B.cf_id, C.company_name, C.description, C.end_date, (C.goal - C.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers B
RIGHT JOIN campaign C
ON C.cf_id = B.cf_id
WHERE C.outcome = 'live'
GROUP BY B.email, B.first_name, B.last_name, B.cf_id, C.company_name, C.description, C.end_date, (C.goal - C.pledged), "Left of Goal"
ORDER BY B.last_name;


DROP TABLE email_backers_remaining_goal_amount;

-- Check the table
SELECT *
From email_backers_remaining_goal_amount LIMIT 10;