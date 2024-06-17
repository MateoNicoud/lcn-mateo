<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
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
//        Création des utilisateurs
        DB::table('users')->insert([
            'username' => 'Rose',
            'email' => 'rose@mail.com',
            'password' => Hash::make('pwd'),
            'image' => null,
            'bio' => 'Je voudrais devenir enseignante pour enfants.'
        ]);
        DB::table('users')->insert([
            'username' => 'Musonda',
            'email' => 'musonda@mail.com',
            'password' => Hash::make('pwd2'),
            'image' => null,
            'bio' => 'Je songe à devenir infirmière, j\'écris mes réflexions.'
        ]);
//        Création des lien de follow (1 = Rose, 2 = Musonda)
        DB::table('followers')->insert([
            'follower_id' => 1,
            'following_id' => 2
        ]);
        DB::table('followers')->insert([
            'follower_id' => 2,
            'following_id' => 1
        ]);
//        Création des articles
        DB::table('articles')->insert([
            'user_id' => 1,
            'title' => 'Devenir enseignante',
            'slug' => 'devenir-enseignante',
            'description' => 'Je suis passionnée par l\'enseignement, je veux devenir enseignante.',
            'body' => 'Je suis passionnée par l\'enseignement, je veux devenir enseignante. Je suis passionnée par l\'enseignement, je veux devenir enseignante. Je suis passionnée par l\'enseignement, je veux devenir enseignante. Je suis passionnée par l\'enseignement, je veux devenir enseignante. Je suis passionnée par l\'enseignement, je veux devenir enseignante.'
        ]);
        DB::table('articles')->insert([
            'user_id' => 2,
            'title' => 'Devenir infirmière',
            'slug' => 'devenir-infirmiere',
            'description' => 'Je suis passionnée par la médecine, je veux devenir infirmière.',
            'body' => 'Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière.'
        ]);
        DB::table('articles')->insert([
            'user_id' => 2,
            'title' => 'Devenir infirmière2',
            'slug' => 'devenir-infirmiere-2',
            'description' => 'Je suis passionnée par la médecine, je veux devenir infirmière.',
            'body' => 'Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière. Je suis passionnée par la médecine, je veux devenir infirmière.'
        ]);
//        Création des tags
        DB::table('tags')->insert([
            'name' => 'éducation'
        ]);
//        Création des liens entre articles et tags tag_id = 1 (éducation) article_id = 1 (Devenir enseignante)
        DB::table('article_tag')->insert([
            'article_id' => 1,
            'tag_id' => 1
        ]);
        DB::table('comments')->insert([
            'user_id' => 2,
            'article_id' => 1,
            'body' => 'Je suis passionnée par l\'enseignement, je veux devenir enseignante.'
        ]);
    }
}
