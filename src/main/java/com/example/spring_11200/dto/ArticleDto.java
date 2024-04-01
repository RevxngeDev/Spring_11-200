package com.example.spring_11200.dto;

import com.example.spring_11200.models.Article;
import com.example.spring_11200.models.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ArticleDto {
    private Long id;
    private String text;
    private String authorName;
    private Integer likeCount;

    public static ArticleDto from(Article article) {
        Integer likeCount = 0;
        if (article.getLikes() != null) {
            likeCount = article.getLikes().size();
        }
        return ArticleDto.builder()
                .id(article.getArticleId())
                .text(article.getText())
                .authorName(article.getAuthor().getEmail())
                .likeCount(likeCount)
                .build();
    }

    public static List<ArticleDto> articleList(List<Article> articles){
        return articles.stream()
                .map(ArticleDto::from)
                .collect(Collectors.toList());
    }
}
