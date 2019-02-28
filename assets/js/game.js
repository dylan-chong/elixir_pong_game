import "pixi";
import "p2";
import Phaser from "phaser";

class Game {
  constructor() {
    this.game = new Phaser.Game(1920, 1080, Phaser.AUTO, '', {
      preload: this.preload.bind(this),
      create: this.create.bind(this),
      update: this.update.bind(this)
    });
  }
  preload() {
    this.game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
    this.game.scale.pageAlignHorizontally = true;
    this.game.scale.pageAlignVertically = true;

    this.game.load.image('star', '/images/star.png');
    this.game.load.image('paddle', '/images/paddle.png');
  }
  create() {
    this.star = this.game.add.sprite(32, this.game.world.height - 150, 'star');
    this.game.physics.arcade.enable(this.star);

    //  Player physics properties. Give the little guy a slight bounce.
    this.star.body.bounce.y = 1;
    this.star.body.bounce.x = 1;
    this.star.body.gravity.y = 0;
    this.star.body.collideWorldBounds = true;

  	this.star.body.velocity.x = 200;
  	this.star.body.velocity.y = 200;

  	this.paddle = this.game.add.sprite(20, 20, 'paddle')
  }
  update() {
    if (!this.serverGameState) {
      return
    }
    this.paddle.x = this.serverGameState.position.x
    this.paddle.y = this.serverGameState.position.y
  }
  setNewState(state) {
    this.serverGameState = state
  }
}

export let game = new Game()