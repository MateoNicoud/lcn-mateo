<?php


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
        DB::table('users')->insert([
            'username' => 'Rose',
            'email' => 'rose@gmail.com',
            'password' => Hash::make('pwd'),
            'image' => null,
            'bio' => 'Je voudrais devenir enseignante pour enfants'
        ]);
        DB::table('users')->insert([
            'username' => 'Musonda',
            'email' => 'musonda@gmail.com',
            'password' => Hash::make('pwd2'),
            'image' => null,
            'bio' => 'Je songe à devenir infirmière, j’écris mes réflexions'
        ]);

        // Musonda suit Rose
        DB::table('followers')->insert([
            'following_id' => 2,
            'follower_id' => 1
        ]);
        // Rose suit Musonda
        DB::table('followers')->insert([
            'following_id' =>1,
            'follower_id' => 2
        ]);


        DB::table('articles')->insert([
            'title' => 'Réflexions sur le soin infirmier',
            'description' => 'Description de l\'article 1',
            'slug' => 'ARTICLE 1',
            'body' => 'Ceci est le contenu du premier article.',
            'user_id' => 1
        ]);
        // Musonda suit l'article de Rose
        DB::table('article_user')->insert([
            'article_id' => 1,
            'user_id' => 2
        ]);

        // Insertion des articles écrits par Musonda
        DB::table('articles')->insert([
            'title' => 'Réflexions sur le soin infirmier',
            'slug' => 'ARTICLE 2',
            'description' => 'Description de l\'article 2',
            'body' => 'Ceci est le contenu du premier article.',
            'user_id' => 2
        ]);
        DB::table('article_user')->insert([
            'article_id' => 2,
            'user_id' => 1
        ]);
        DB::table('articles')->insert([
            'title' => 'L\'importance de la compassion',
            'description' => 'Description de l\'article 3',
            'slug' => 'ARTICLE 3',
            'body' => 'Ceci est le contenu du deuxième article.',
            'user_id' => 2
        ]);
        // Rose suit les articles de Musonda
        DB::table('article_user')->insert([
            'article_id' => 3,
            'user_id' => 1
        ]);


        // Récupérer le tag "éducation"
        $educationTagId = DB::table('tags')->insert([
            'name' => 'education',
        ]);

        DB::table('article_tag')->insert([
            'article_id' => 1,
            'tag_id' => $educationTagId
        ]);

        DB::table('comments')->insert([
            'user_id' => 2,
            'article_id' => 1,
            'body'=>'J\'adore ta manière de concevoir l\'éducation des enfants, Rose.'
        ]);
    }
}
