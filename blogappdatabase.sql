DROP TABLE tags, comments, posts, users;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT NOT NULL,
    user_name TEXT NOT NULL
);

CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    title TEXT,
    content TEXT,
    creator_id INT REFERENCES users,
    publishedAt TIMESTAMP default current_timestamp
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    comment_text TEXT,
    creator_id INT REFERENCES users NOT NULL,
    post_id INT REFERENCES posts NOT NULL
);

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag_text TEXT NOT NULL
);

INSERT INTO users 
        (first_name, last_name, email, user_name) 
    VALUES
        ('Joe', 'Blow', 'joe@blow.com', 'joeblow'),
        ('Donald', 'Trump', 'trump@whitehouse.gov', 'trump');

INSERT INTO posts 
        (title, content, creator_id) 
    VALUES
        ('great blog post', 'your ad here', 1),
        ('learn to cook', 'start with bread', 2);

INSERT INTO comments 
        (comment_text, creator_id, post_id)
    VALUES
        ('Great information, thank you', 1, 1),
        ('THIS POST SUX!!!11!', 2, 1);

INSERT INTO tags 
        (tag_text) 
    VALUES
        ('cats'),
        ('NSFW'), 
        ('funny');

SELECT comments.id, comments.comment_text, posts.post_id, posts.title
    FROM posts
    INNER JOIN comments
    ON comments.post_id = posts.post_id