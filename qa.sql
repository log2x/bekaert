UPDATE `cms_page` SET content = REGEXP_REPLACE(content, "(dev|qa)-api", "api") where content REGEXP '(dev|qa)-api';
