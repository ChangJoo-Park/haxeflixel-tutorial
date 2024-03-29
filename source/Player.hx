import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Player extends FlxSprite {
	public var speed:Float = 200;

	var _up:Bool = false;
	var _down:Bool = false;
	var _left:Bool = false;
	var _right:Bool = false;

	public function new(?X:Float = 0, ?Y:Float = 0) {
		super(X, Y);

		loadGraphic(AssetPaths.player__png, true, 16, 16);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		drag.x = drag.y = 1600;
	}

	override function update(elapsed:Float) {
		movement();
		super.update(elapsed);
	}

	function movement():Void {
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);

		if (_up && _down) {
			_up = _down = false;
		}
		if (_left && _right) {
			_left = _right = false;
		}

		if (_up || _down || _left || _right) {
			velocity.x = speed;
			velocity.y = speed;
		} else {
			velocity.x = 0;
			velocity.y = 0;
			return;
		}

		var mA:Float = 0;

		if (_up) {
			mA = -90;
			if (_left) {
				mA -= 45;
			} else if (_right) {
				mA += 45;
			}
			facing = FlxObject.UP;
		} else if (_down) {
			mA = 90;
			if (_left) {
				mA += 45;
			} else if (_right) {
				mA -= 45;
			}
			facing = FlxObject.DOWN;
		} else if (_left) {
			mA = 180;
			facing = FlxObject.LEFT;
		} else if (_right) {
			mA = 0;
			facing = FlxObject.RIGHT;
		}

		velocity.set(speed, 0);
		velocity.rotate(FlxPoint.weak(0, 0), mA);

		// if the player is moving (velocity is not 0 for either axis), we need to change the animation to match their facing
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
			switch (facing) {
				case FlxObject.LEFT, FlxObject.RIGHT:
					animation.play("lr");
				case FlxObject.UP:
					animation.play("u");
				case FlxObject.DOWN:
					animation.play("d");
			}
		}
	}
}
