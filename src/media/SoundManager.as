package media
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SoundManager
	{
		//public static consts with array int in them bijv: public static const GAME_MUSIC : int = 0;
		
		private static var soundVolume : Number = 0.7;
		private static var musicVolume : Number = 0.5;
		
		private static var soundTransform : SoundTransform = new SoundTransform(soundVolume);
		private static var musicTransform : SoundTransform = new SoundTransform(musicVolume);
		
		private static var soundChannel : SoundChannel = new SoundChannel();
		private static var musicChannel : SoundChannel = new SoundChannel();
		
		private static var musicPausePos : int;
		private static var currentMusic : Sound;
		
		private static var constSound : Sound = null;
		
		private static var totalSoundsLoaded : int = 0;
		public static var allSoundsLoaded : Boolean = false;
		private static var allUrls : Array = [];
		private static var allSounds : Array = [];
		
		/**
			* Use this function before sarting the game to load all sounds. 
			* add an EnterframeEvent to class that checks if SoundManager.allSoundsLoaded is true. if true then you can add game or something else and remove the listener
		*/
		public static function loadSounds() : void {
			
			// music (all url requests) bijv: allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/Instrument.mp3")); // Menu Music
			
			//sounds/effects
			for (var i : int = 0; i < allUrls.length; i++) {
				
				var sound : Sound = new Sound();
				sound.addEventListener(Event.COMPLETE, soundLoaded);
				sound.load(allUrls[i]);
				allSounds.push(sound);
				
			}
			if (allUrls.length == 0) {
				allSoundsLoaded = true;
			}
		}
		
		static private function soundLoaded(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, soundLoaded);
			allSoundsLoaded += 1;
			if (allSoundsLoaded == allUrls.length && allSoundsLoaded == allSounds.length) {
				allSoundsLoaded = true;
			}
		}
		
		public static function playSound(soundInt : int, repeat : int = 0, startInMili : int = 0) :void {
			var sound : Sound = new Sound();
			sound = allSounds[soundInt];
			
			if(sound != null){
				soundChannel = sound.play(startInMili,repeat,soundTransform);
			}
		}
		public static function playMusic(soundInt : int, repeat : int = 9999, startInMili : int = 0) :void {
			var sound : Sound = new Sound();
			sound = allSounds[soundInt];
			
			if(sound != null){
				musicChannel.stop();
				musicChannel = sound.play(startInMili, repeat, musicTransform);
			}
		}
		
		/**
			* The sound will play to the end until it can be played again.
			* @usage: Used for sounds you ask for faster than you want to play them.
		*/
		public static function playToEnd(soundInt : int, startInMili : int = 0) : void {
			//used for sounds you ask for faster than you want to play them. Waka after eating cookie in pacman.
			var sound : Sound = new Sound();
			sound = allSounds[soundInt];
			
			if (constSound == null) {
				constSound = sound;
				soundChannel = constSound.play(startInMili,0,soundTransform);
				soundChannel.addEventListener(Event.SOUND_COMPLETE, setConstNull);
			}
		}
		
		private static function setConstNull(e:Event):void 
		{
			soundChannel.removeEventListener(Event.COMPLETE, setConstNull);
			constSound = null;
		}
		
		public static function toggleMuteSound() :Boolean {
			if (soundTransform.volume == 0) {
				soundTransform.volume = soundVolume;
				return true;
			}else {
				soundTransform.volume = 0;
				return false;
			}
		}
		public static function toggleMuteMusic() :Boolean {
			if (musicTransform.volume == 0) {
				musicTransform.volume = musicVolume;
				musicChannel = currentMusic.play(musicPausePos, 999, musicTransform);
				return true;
			}else {
				musicPausePos = musicChannel.position;
				musicChannel.stop();
				musicTransform.volume = 0;
				return false;
			}
		}
		public static function stopSound() :void {
			soundChannel.stop();
			musicChannel.stop();
		}
	}

}