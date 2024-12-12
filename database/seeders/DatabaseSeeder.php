<?php

namespace Database\Seeders;

use App\Models\{Category, User};
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
        User::factory()->create([
            'role' => 'admin',
        ]);
        User::factory()->count(4)->create([
            'role' => 'author',
        ]);
        User::factory()->count(8)->create();

        // insert default users
        DB::table('users')->insert([
            [
                'name' => 'Kays',
                'email' => 'kays.zahidi@eemi.com',
                'password' => Hash::make('12345678'),
                'role' => 'admin',
                'valid' => 1
            ],
            [
                'name' => 'Kamissoko',
                'email' => 'silamakankamissoko@gmail.com',
                'password' => Hash::make('12345678'),
                'role' => 'admin',
                'valid' => 1
            ]
        ]);

        DB::table('tags')->insert([
            [
                'tag' => 'Tag 1', 
            ],
            [
                'tag' => 'Tag 2',
            ],
            [
                'tag' => 'Tag 3',
            ],
            [
                'tag' => 'Tag 4',
            ],
            [
                'tag' => 'Tag 5',
            ],
            [
                'tag' => 'Tag 6',
            ]
        ]);

        // insert categories
        Category::create(['title' => 'Technology']);
        Category::create(['title' => 'Health']);
        Category::create(['title' => 'Travel']);
        Category::create(['title' => 'Food']);
        Category::create(['title' => 'Education']);
        Category::create(['title' => 'Lifestyle']);
    }
}