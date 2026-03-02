CREATE DATABASE social_media_analytics;
USE social_media_analytics;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT,
    post_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    like_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);

CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    comment_text TEXT,
    comment_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);

INSERT INTO users (username, email, join_date) VALUES
('Aisha', 'aisha@gmail.com', '2023-01-10'),
('Rahul', 'rahul@gmail.com', '2023-02-15'),
('Sneha', 'sneha@gmail.com', '2023-03-20');

INSERT INTO posts (user_id, content, post_date) VALUES
(1, 'My first post!', NOW()),
(2, 'Hello world!', NOW()),
(1, 'Learning SQL is fun!', NOW());

INSERT INTO likes (user_id, post_id, like_date) VALUES
(2, 1, NOW()),
(3, 1, NOW()),
(1, 2, NOW());

INSERT INTO comments (user_id, post_id, comment_text, comment_date) VALUES
(2, 1, 'Nice post!', NOW()),
(3, 1, 'Great!', NOW()),
(1, 2, 'Welcome!', NOW());

SELECT u.username, COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.username
ORDER BY total_posts DESC;

SELECT p.post_id, p.content, COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY total_likes DESC;

SELECT u.username,
       COUNT(DISTINCT l.like_id) AS total_likes,
       COUNT(DISTINCT c.comment_id) AS total_comments
FROM users u
LEFT JOIN likes l ON u.user_id = l.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
GROUP BY u.username;

SELECT p.post_id,
       COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS engagement
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id
ORDER BY engagement DESC;

