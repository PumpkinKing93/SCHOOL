<?php


// PHP Active record example

//////////
// CREATE
//////////

$post = new Post();
$post->title = 'My first blog post!!';
$post->author_id = 5;
$post->save();
# INSERT INTO `posts` (title,author_id) VALUES('My first blog post!!', 5)
 
# the below methods accomplish the same thing
 
$attributes = array('title' => 'My first blog post!!', 'author_id' => 5);
$post = new Post($attributes);
$post->save();
# same sql as above
 
$post = Post::create($attributes);
# same sql as above


// READ
////////
$post = Post::find(1);
echo $post->title; # 'My first blog post!!'
echo $post->author_id; # 5
 
# also the same since it is the first record in the db
$post = Post::first();
 
# using dynamic finders
$post = Post::find_by_name('The Decider');
$post = Post::find_by_name_and_id('The Bridge Builder',100);
$post = Post::find_by_name_or_id('The Bridge Builder',100);
 
# using some conditions
$posts = Post::find('all',array('conditions' => array('name=?','The Bridge Builder')));

// UPDATE
/////////
$post = Post::find(1);
echo $post->title; # 'My first blog post!!'
$post->title = 'Some real title';
$post->save();
# UPDATE `posts` SET title='Some real title' WHERE id=1

$post->update_attributes(array('title' => 'Some other title', 'author_id' => 1));
# UPDATE `posts` SET title='Some other title', author_id=1 WHERE id=1

// DELETE
/////////
$post = Post::find(1);
$post->delete();
# DELETE FROM `posts` WHERE id=1

echo $post->title; # Some other title

// MASSIVE UPDATE OR DELETE# MASSIVE UPDATE
# Model::table()->update(AttributesToUpdate, WhereToUpdate);
Post::table()->update(array('title' => 'Massive title!', /* Other attributes... */, array('id' => array(1, 3, 7));
# UPDATE `posts` SET title = `Massive title!` WHERE id IN (1, 3, 7)
 
# MASSIVE DELETE
# Model::table()->delete(WhereToDelete);
Post::table()->delete(array('id' => array(5, 9, 26, 30));
# DELETE FROM `posts` WHERE id IN (5, 9, 26, 30)

?>