-- ▼ Q1: departments テーブル作成
CREATE TABLE departments (
  department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ▼ Q2: people テーブルに department_id を追加
ALTER TABLE people
ADD COLUMN department_id INT UNSIGNED AFTER email;

-- ▼ Q3: departments レコード追加
INSERT INTO departments (name) VALUES
('営業'), ('開発'), ('経理'), ('人事'), ('情報システム');

-- ▼ Q3: people レコード追加
INSERT INTO people (name, email, department_id, age, gender) VALUES
('田中一郎', 'ichiro@example.com', 1, 28, 1),
('佐藤花子', 'hanako@example.com', 2, 30, 2),
('鈴木健太', 'kenta@example.com', 1, 25, 1),
('中村明美', 'akemi@example.com', 4, 42, 2),
('高橋翔', 'sho@example.com', 2, 29, 1),
('山本愛', 'ai@example.com', 5, 27, 2),
('伊藤剛', 'go@example.com', 2, 31, 1),
('渡辺優子', 'yuko@example.com', 3, 35, 2),
('小林直樹', 'naoki@example.com', 1, 24, 1),
('加藤久美', 'kumi@example.com', 2, 26, 2);

-- ▼ Q3: reports レコード追加
INSERT INTO reports (person_id, report_date, content) VALUES
(1, '2025-07-01', '本日営業先5件訪問しました。'),
(2, '2025-07-01', '新機能の設計完了。'),
(3, '2025-07-01', 'クライアント訪問し要望確認。'),
(4, '2025-07-01', '採用候補者と面談。'),
(5, '2025-07-01', '開発ミーティング実施。'),
(6, '2025-07-01', '社内ネットワーク点検。'),
(7, '2025-07-01', 'バグ対応完了。'),
(8, '2025-07-01', '経理チェック実施。'),
(9, '2025-07-01', '新規顧客対応。'),
(10, '2025-07-01', 'ユニットテスト完了。');

-- ▼ Q4: department_id が NULL の人を更新
UPDATE people
SET department_id = 1
WHERE department_id IS NULL;

-- ▼ Q5: 男性を年齢降順で取得
SELECT name, age FROM people
WHERE gender = 1
ORDER BY age DESC;

-- ▼ Q6: 日本語説明コメント付きSQL
-- peopleテーブルから、部署IDが1である人の名前、メールアドレス、年齢を、作成日時順に取得
SELECT name, email, age
FROM people
WHERE department_id = 1
ORDER BY created_at;

-- ▼ Q7: 20代女性と40代男性の名前一覧を取得
SELECT name FROM people
WHERE (gender = 2 AND age BETWEEN 20 AND 29)
   OR (gender = 1 AND age BETWEEN 40 AND 49);

-- ▼ Q8: 営業部に所属する人を年齢昇順で取得
SELECT name, age FROM people
WHERE department_id = (
  SELECT department_id FROM departments WHERE name = '営業'
)
ORDER BY age ASC;

-- ▼ Q9: 開発部の女性の平均年齢を取得
SELECT AVG(age) AS average_age
FROM people
WHERE gender = 2
  AND department_id = (
    SELECT department_id FROM departments WHERE name = '開発'
  );

-- ▼ Q10: 名前、部署、日報内容（提出者のみ）
SELECT p.name, d.name AS department, r.content
FROM people p
JOIN departments d ON p.department_id = d.department_id
JOIN reports r ON p.person_id = r.person_id;

-- ▼ Q11: 日報未提出者の名前一覧
SELECT name FROM people
WHERE person_id NOT IN (
  SELECT DISTINCT person_id FROM reports
);


-- lesson10 start
-- lesson10 start
-- Q9: 開発部に所属している女性の平均年齢を取得
SELECT AVG(age) AS average_age FROM people WHERE department_id = 2 AND gender = 2;
-- Q10: 名前、部署名、提出した日報の内容を取得（未提出者は含まない）
SELECT p.name, d.name AS department_name, r.content FROM people p INNER JOIN departments d ON p.department_id = d.department_id INNER JOIN reports r ON p.person_id = r.person_id;
-- Q11: 部署ごとの日報投稿数（多い順）
SELECT d.name AS department_name, COUNT(r.report_id) AS report_count FROM departments d INNER JOIN people p ON d.department_id = p.department_id INNER JOIN reports r ON p.person_id = r.person_id GROUP BY d.department_id ORDER BY report_count DESC;
-- Q9: 開発部に所属している女性の平均年齢を取得
SELECT AVG(age) AS average_age FROM people WHERE department_id = 2 AND gender = 2;
-- Q10: 名前、部署名、提出した日報の内容を取得（未提出者は含まない）
SELECT p.name, d.name AS department_name, r.content FROM people p INNER JOIN departments d ON p.department_id = d.department_id INNER JOIN reports r ON p.person_id = r.person_id;
-- Q11: 部署ごとの日報投稿数（多い順）
SELECT d.name AS department_name, COUNT(r.report_id) AS report_count FROM departments d INNER JOIN people p ON d.department_id = p.department_id INNER JOIN reports r ON p.person_id = r.person_id GROUP BY d.department_id ORDER BY report_count DESC;
