package com.example.spring_11200.controllers;

import com.example.spring_11200.dto.ArticleDto;
import com.example.spring_11200.dto.ArticleForm;
import com.example.spring_11200.services.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
@Controller
public class ArticleController {
    @Autowired
    private ArticleService articleService;

    @PostMapping("/users/{user-id}/article")
    @ResponseBody
    public ArticleDto addArticle(@PathVariable("user-id") Long id,
                                 @RequestBody ArticleForm articleForm){
        return articleService.addArticle(id, articleForm);
    }
    @GetMapping("/users/{user-id}/article")
    public String getArticlesOfUser(@PathVariable("user-id") Long id, Model model){
        model.addAttribute("articles", articleService.getByUser(id));
        return "article_page";
    }
    @PostMapping("/users/{user-id}/articles/{article-id}/like")
    @ResponseBody
    public Object like(@PathVariable("user-id")Long userId,
                       @PathVariable("article-id") Long articleId){
        return articleService.like(userId, articleId);
    }
}
