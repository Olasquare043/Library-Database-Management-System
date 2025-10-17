-- **Q2.** Find all members who joined in the last 2 years and have a 'Premium' membership.

SELECT * FROM members WHERE "TypeOfMembership"='Premium' 
AND "DateOfMembership">= CURRENT_DATE - INTERVAL '2 years';