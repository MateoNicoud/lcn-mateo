<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use App\Models\Article;
use App\Models\Comment;
use App\Models\Tag;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        //Creating users
        $rose = User::create([
            'username' => 'Rose',
            'email' => 'rose@mail.com',
            'password' => Hash::make('pwd'),
            'bio' => 'Je voudrais devenir enseignante pour enfants',
            'created_at' => now(),
            'updated_at' => now()
        ]);

        $musonda = User::create([
            'username' => 'Musonda',
            'email' => 'musonda@mail.com',
            'password' => Hash::make('pwd2'),
            'bio' => 'Je songe à devenir infirmière, j’écris mes réflexions',
            'created_at' => now(),
            'updated_at' => now()
        ]);

        // Relationship between User
        $rose->following()->attach($musonda->id);
        $musonda->following()->attach($rose->id);

        // Creating articles
        $roseArticle = Article::create([
            'user_id' => $rose->id,
            'title' => 'Enseigner',
            'slug' => 'Lorem ipsum blabla',
            'description' => 'Lorem ipsum blabladjsqkldjdjsqdlsqjdvmclkdqs',
            'body' => 'Lorem ipsum blabladjsqkldjdjsdsqdjqldjqdlsqjdvmclkdqs'
        ]);
        $musondaArticle1 = Article::create([
            'user_id' => $musonda->id,
            'title' => 'Devenir Infirmière : Tome 1',
            'slug' => 'Lorem ipsum blabla',
            'description' => 'Lorem ipsum blabladjsqkldjdjsqdlsqjdvmclkdqs',
            'body' => 'Lorem ipsum blabladjsqkldjdjsdsqdjqldjqdlsqjdvmclkdqs'
        ]);

        $musondaArticle2 = Article::create([
            'user_id' => $musonda->id,
            'title' => 'Devenir Infirmière : Tome 2',
            'slug' => 'Lorem ipsum blabla',
            'description' => 'Lorem ipsum blabladjsqkldjdjsqdlsqjdvmclkdqs',
            'body' => 'Lorem ipsum blabladjsqkldjdjsdsqdjqldjqdlsqjdvmclkdqs'
        ]);

        // Relationship between articles
        $musonda->favoritedArticles()->attach($roseArticle->id);
        $rose->favoritedArticles()->attach($musondaArticle1->id);
        $rose->favoritedArticles()->attach($musondaArticle2->id);

        // Creating Tags
        $educationTag = Tag::create([
            'name' => 'Education'
        ]);

        // Relationship Tags with articles
        $roseArticle->tags()->attach($educationTag->id);

        // Creating comments
        $musondaComment = Comment::create([
            'user_id' => $musonda->id,
            'article_id' => $roseArticle->id,
            'body' => "J'adore ta manière de concevoir l’éducation des enfants",
            'created_at' => now(),
            'updated_at' => now(),
        ]);

    }

}
