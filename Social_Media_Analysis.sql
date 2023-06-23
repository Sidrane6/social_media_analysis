CREATE DATABASE social_media;
USE social_media;
CREATE TABLE social_media_post (
post_id INT PRIMARY KEY,
post_date DATE,
post_content VARCHAR(200));

CREATE TABLE post_engagement (
post_id INT,
likes INT,
Comments INT,
shares INT);


CREATE TABLE post_impressions (
post_id INT,
impressions INT);

INSERT INTO  social_media_post(post_id, post_date, post_content)
VALUES (1, '2023-01-01', 'Check out our new product! #launch'),
       (2, '2023-01-02', 'Exciting news! Stay tuned for updates'),
       (3, '2023-01-03', 'Join us for a special event'),
       (4, '2023-01-04', 'Our latest blog post is out'),
       (5, '2023-01-05', 'Get ready for our flash sale');
       
INSERT INTO  post_engagement(post_id,likes, comments, shares)
VALUES (1,500,50,	100),
(2,	1000,	80	,200),
(3,	800,	60,	150),
(4,	1200,	100,	300),
(5,	600,	70,	120);


INSERT INTO  post_impressions(post_id,impressions)
VALUES (1,	1000),
(2	,1500),
(3,	1200),
(4,	1800),
(5	,900);

SELECT * FROM social_media_post;
SELECT * FROM post_impressions;
SELECT * FROM post_engagement;

-- 1.What is the total number of social media posts in the dataset?
SELECT count(post_id) TOTAL_POST FROM social_media_post;

SELECT COUNT(*) AS total_posts
FROM social_media_post;

-- 2.Which post received the highest number of likes? Retrieve the post content as well.
SELECT a.post_id,a.post_content,b.likes FROM social_media_post a INNER JOIN post_engagement b ON a.post_id=b.post_id 
ORDER BY b.likes DESC
LIMIT 1;

-- 3. Calculate the average number of comments per post.

SELECT AVG(comments) AS avg_comments_per_post 
FROM post_engagement;

-- 4.Determine the top 3 posts with the highest engagement (likes + comments + shares).
SELECT * FROM social_media_post;
SELECT * FROM post_impressions;
SELECT * FROM post_engagement;

SELECT  post_id, SUM(likes+comments+shares) AS highest_engagement
 FROM post_engagement
 group by post_id
 ORDER BY highest_engagement DESC 
 LIMIT 3;


SELECT p.post_id, p.post_content, (e.likes + e.comments + e.shares) AS total_engagement
FROM social_media_post p
INNER JOIN post_engagement e ON p.post_id = e.post_id
ORDER BY total_engagement DESC
LIMIT 3;

-- 5 How many impressions did each post receive on average?
SELECT AVG(impressions) AS avg_impression_perpost FROM post_impressions;

-- 6 Calculate the total number of likes, comments, and shares for all posts combined.
SELECT SUM(likes) AS total_likes, sum(comments) AS total_comments, sum(shares) AS Total_shares FROM post_engagement;

-- 7 Identify the post with the highest number of impressions.
SELECT * FROM post_impressions ORDER BY post_id LIMIT 1;

SELECT p.post_id, p.post_content, e.impressions 
FROM social_media_post p;

-- 8 What is the average number of likes per post on a daily basis?


SELECT DATE(post_date) AS post_date, AVG(likes) AS average_likes_per_post
FROM social_media_post
INNER JOIN post_engagement ON social_media_post.post_id = post_engagement.post_id
GROUP BY DATE(post_date);

-- 9 Calculate the engagement rate (likes + comments + shares) per post for each day.
   SELECT
    DATE(p.post_date) AS post_day,
    p.post_id,
    SUM(e.likes + e.comments + e.shares) AS total_engagement,
    i.impressions,
    SUM(e.likes + e.comments + e.shares) / i.impressions AS engagement_rate
FROM
    social_media_post p
INNER JOIN
    post_engagement e ON p.post_id = e.post_id
INNER JOIN
    post_impressions i ON p.post_id = i.post_id
GROUP BY
    post_day, p.post_id, i.impressions;


SELECT p.post_id, p.post_date, SUM(e.likes + e.comments + e.shares) AS total_engagement
FROM social_media_post p
INNER JOIN post_engagement e ON p.post_id = e.post_id
GROUP BY post_id
ORDER BY total_engagement DESC;

-- 10 Which day had the highest engagement rate across all posts?
SELECT p.post_id, p.post_date, SUM(e.likes + e.comments + e.shares) AS total_engagement
FROM social_media_post p
INNER JOIN post_engagement e ON p.post_id = e.post_id
GROUP BY post_id
ORDER BY total_engagement DESC
limit 1;

-- 11 
SELECT * FROM post_engagement;

SELECT (SUM((likes - avg_likes) * (comments - avg_comments)) / 
        (SQRT(SUM(POW(likes - avg_likes, 2))) * SQRT(SUM(POW(comments - avg_comments, 2)))))
       AS correlation
FROM (
    SELECT AVG(likes) AS avg_likes, AVG(comments) AS avg_comments
    FROM post_engagement
) AS subquery, post_engagement;

-- 12 Calculate the average number of impressions per post for each day.
SELECT p.post_id, p.post_date AS dates, AVG(e.impressions) AS avg_impressions
FROM social_media_post p
INNER JOIN post_impressions e ON p.post_id = e.post_id
GROUP BY 2;

INSERT INTO  social_media_post(post_id, post_date, post_content)
VALUES (6, '2023-01-01', 'SID'),
       (7, '2023-01-01', 'RK'),
       (8, '2023-01-02', 'SRK'),
       (9, '2023-01-02', 'RK & SRK'),
       (10, '2023-01-05', 'SRK & RK');
	SELECT * FROM social_media_post;
    
    
    
INSERT INTO  post_impressions(post_id,impressions)
VALUES (6,	1000),
(7	,1500),
(8,	1200),
(9,	1800),
(10	,900);

SELECT  p.post_date, AVG(e.impressions) AS avg_impressions
FROM social_media_post p
INNER JOIN post_impressions e ON p.post_id = e.post_id
GROUP BY p.post_date;

-- 13 Determine the top 3 posts with the highest engagement rate (likes + comments + shares) per impression.

INSERT INTO  post_engagement(post_id,likes, comments, shares)
VALUES (6,500,50,	100),
(7,	1000,	80	,200),
(8,	800,	60,	150),
(9,	1200,	100,	300),
(10,	600,	70,	120);

SELECT a.post_id,a.post_date, a.post_content, (b.likes+b.comments+b.shares) /c.impressions AS engagement_rate
FROM social_media_post a
INNER JOIN post_engagement b ON a.post_id=b.post_id
INNER JOIN post_impressions c ON a.post_id=c.post_id
ORDER BY engagement_rate DESC
LIMIT 3;

-- 14 Calculate the total number of impressions for all posts combined.
SELECT sum(impressions) AS totalt_impressions  FROM post_impressions;

-- 15 How many posts received more than 500 likes?
SELECT post_id
FROM post_engagement
WHERE likes =500;


SELECT COUNT(*) AS num_posts
FROM post_engagement
WHERE likes > 500;

-- 16 Calculate the average number of shares per post on weekdays versus weekends.

SELECT 
CASE
WHEN DAYOFWEEK(post_date) IN (1,7) THEN 'Weekend' 
ELSE 'Weekday'
END AS day_type, AVG(shares) as avg_share_per_post
FROM social_media_post
INNER JOIN 
 post_engagement ON social_media_post.post_id = post_engagement.post_id
GROUP BY 
    day_type;

-- 17 Identify the posts with the highest engagement rate (likes + comments + shares) per impression for each day.
SELECT a.post_id,a.post_date, a.post_content, (b.likes+b.comments+b.shares) /c.impressions AS engagement_rate
FROM social_media_post a
INNER JOIN post_engagement b ON a.post_id=b.post_id
INNER JOIN post_impressions c ON a.post_id=c.post_id
ORDER BY engagement_rate DESC;

SELECT p.post_date, p.post_id, (e.likes + e.comments + e.shares) / i.impressions AS engagement_rate
FROM social_media_post p
INNER JOIN post_engagement e ON p.post_id = e.post_id
INNER JOIN post_impressions i ON p.post_id = i.post_id
WHERE (e.likes + e.comments + e.shares) / i.impressions = 
    (SELECT MAX((likes + comments + shares) / impressions)
    FROM post_engagement pe
    INNER JOIN post_impressions pi ON pe.post_id = pi.post_id
    WHERE DATE(p.post_date) = DATE(pe.post_date))
GROUP BY p.post_date, p.post_id, engagement_rate;


-- 18 Calculate the percentage of posts that received more than 1000 impressions.
SELECT 
    COUNT(*) AS num_posts,
    (COUNT(*) / (SELECT COUNT(*) FROM post_impressions)) * 100 AS percentage
FROM 
    post_impressions
WHERE 
    impressions > 1000;
    
-- 19 Determine the average number of likes for posts containing the hashtag "#launch".
SELECT
    AVG(likes) AS average_likes
FROM 
    social_media_post
INNER JOIN 
    post_engagement ON social_media_post.post_id = post_engagement.post_id
WHERE 
    post_content LIKE '%#launch%';
    
-- 20.Calculate the engagement rate (likes + comments + shares) per impression for each post
SELECT 
    p.post_id,
    (e.likes + e.comments + e.shares) / i.impressions AS engagement_rate
FROM 
    social_media_post p
INNER JOIN 
    post_engagement e ON p.post_id = e.post_id
INNER JOIN 
    post_impressions i ON p.post_id = i.post_id;