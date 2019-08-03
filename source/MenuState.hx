import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;

class MenuState extends FlxState {
	var _btnPlay:FlxButton;

	override function create() {
		super.create();
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
    _btnPlay.screenCenter();
    add(_btnPlay);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
	}

	function clickPlay() {
    FlxG.switchState(new PlayState());
  }
}
