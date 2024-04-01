package com.example.spring_11200.repositores;

import com.example.spring_11200.models.Article;
import com.example.spring_11200.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArticleRepository extends JpaRepository<Article, Long> {
    boolean existsByArticleIdAndLikesContaining(Long articleId, User user);
}
