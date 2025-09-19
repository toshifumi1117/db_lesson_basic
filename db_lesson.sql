-- ========================================
-- Q1: 部署テーブル作成
-- ========================================
CREATE TABLE departments (
  department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ========================================
-- Q2: peopleテーブルに部署ID追加
-- ========================================
ALTER TABLE people
ADD COLUMN department_id INT UNSIGNED NULL AFTER email;

-- ========================================
-- Q3: レコード追加
-- ========================================
-- 部署
INSERT INTO departments (name) VALUES
('営業'), ('開発'), ('経理'), ('人事'), ('情報システム');

-- 人（例）
INSERT INTO people (name, email, department_id, age, gender)
VALUES
('佐藤太郎', 'taro@example.com', 1, 30, 1),
('鈴木花子', 'hanako@example.com', 2, 25, 2),
('田中一郎', 'ichiro@example.com', 1, 29, 1),
('山田花子', 'yamada@example.com', 2, 28, 2),
('高橋健', 'ken@example.com', 2, 35, 1),
('伊藤真由美', 'mayumi@example.com', 2, 27, 2),
('小林次郎', 'jiro@example.com', 1, 32, 1),
('松本洋子', 'yoko@example.com', 3, 40, 2),
('加藤大輔', 'daisuke@example.com', 4, 33, 1),
('中村さくら', 'sakura@example.com', 5, 26, 2);

-- 日報（例）
INSERT INTO reports (person_id, content)
VALUES
(1, '顧客訪問を行いました。'),
(2, '新機能の設計を進めました。'),
(3, '営業資料を作成しました。'),
(4, 'コードレビューを実施しました。'),
(5, '仕様調整のミーティングを行いました。'),
(6, '開発環境の整備を行いました。'),
(7, '見積依頼に対応しました。'),
(8, '経費精算を処理しました。'),
(9, '採用面接を担当しました。'),
(10, 'システム運用マニュアルを作成しました。');

-- ========================================
-- Q4: 不完全データ修正
-- ========================================
UPDATE people
SET department_id = 1
WHERE department_id IS NULL;

-- ========================================
-- Q5: 男性の名前と年齢を年齢降順で取得
-- ========================================
SELECT name, age
FROM people
WHERE gender = 1
ORDER BY age DESC;

-- ========================================
-- Q6: クエリ説明
-- ========================================
-- peopleテーブルから、department_idが1のレコードを対象に
-- name・email・ageカラムを取得し、created_atカラムの昇順で並べ替える
SELECT name, email, age
FROM people
WHERE department_id = 1
ORDER BY created_at;

-- ========================================
-- Q7: 20代女性と40代男性の名前一覧
-- ========================================
SELECT name
FROM people
WHERE (gender = 2 AND age BETWEEN 20 AND 29)
   OR (gender = 1 AND age BETWEEN 40 AND 49);

-- ========================================
-- Q8: 営業部に所属する人を年齢昇順で取得
-- ========================================
SELECT name, age
FROM people
WHERE department_id = 1   -- 営業部のID
ORDER BY age ASC;

-- ========================================
-- Q9: 開発部に所属している女性の平均年齢を取得
-- ========================================
SELECT AVG(age) AS average_age
FROM people
WHERE department_id = 2   -- 開発部のID
  AND gender = 2;


-- ========================================
-- Q10: 名前・部署名・日報内容を同時取得
-- ========================================
SELECT p.name, d.name AS department_name, r.content
FROM people p
JOIN departments d ON p.department_id = d.department_id
JOIN reports r ON p.person_id = r.person_id;

-- ========================================
-- Q11: 日報未提出者の名前一覧
-- ========================================
SELECT p.name
FROM people p
WHERE NOT EXISTS (
  SELECT 1 FROM reports r WHERE r.person_id = p.person_id
);

-- テスト用コメント
-- 確認用コメント
-- 差分確認用コメント
