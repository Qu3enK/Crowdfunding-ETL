-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT b.cf_id, 
	count(b.backer_id) as backer_counts,
	c.outcome
FROM backers as b
JOIN campaign as c 
	ON c.cf_id = b.cf_id
WHERE outcome = 'live'
GROUP BY b.cf_id, c.outcome
ORDER BY backer_counts DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_id, count(backer_id) as backer_counts
FROM backers
GROUP BY cf_id
ORDER BY backer_counts DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT c.first_name,
	c.last_name,
	c.email,
	(cmp.goal-cmp.pledged) as "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as c
JOIN campaign as cmp
	ON cmp.contact_id = c.contact_id
WHERE outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT *
FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT b.email,
	b.first_name,
	b.last_name,
	cmp.cf_id,
	cmp.company_name,
	cmp.description,
	cmp.end_date,
	(cmp.goal-cmp.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
JOIN campaign as cmp
	ON cmp.cf_id = b.cf_id
WHERE cmp.outcome = 'live'
ORDER BY b.last_name, b.first_name;


-- Check the table
SELECT * 
FROM email_backers_remaining_goal_amount;