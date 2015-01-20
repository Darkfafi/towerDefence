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
		public static const MENU_MUSIC : int = 0;
		public static const GAME_MUSIC : int = 1;
		
		public static const SKY_LASER_SOUND : int = 2;
		public static const CANON_TOWER_SOUND : int = 3;
		public static const ELECTRIC_ZAP_SOUND : int = 4;
		
		public static const BUTTON_SOUND : int = 5;
		public static const BUILDING_PLACE_SOUND : int = 6;
		public static const UNIT_PLACED_SOUND : int = 7;
		public static const BUILD_UNIT_MADE : int = 8;
		
		//Voices
		public static const UTOPIA_MY_ASS : int = 9;
		
		public static const I_CAN_BUILD_IT: int = 10;
		
		public static const NAHAHAHHAAHA: int = 11;
		
		
		//------------------------------------------\\
		
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
			
			//Music
			allUrls.push(new URLRequest("https://www.dropbox.com/s/3bjx1xmyeryhxfv/MenuMusic.mp3?dl=1")); // Menu Music
			allUrls.push(new URLRequest("https://www.dropbox.com/s/uaka2elut79fdez/GameMusic.mp3?dl=1")); // Game Music
			
			//Sounds Effects Towers
			allUrls.push(new URLRequest("https://www.dropbox.com/s/18bf4n4wzhdqjpl/SkyLaserTowerSound.mp3?dl=1")); // skyLaserTower sound
			allUrls.push(new URLRequest("https://www.dropbox.com/s/u2nhppmbfmd4z5a/CanonTowerSound.mp3?dl=1")); // Canon Tower sound
			allUrls.push(new URLRequest("https://www.dropbox.com/s/t6tefvgj2o8c5xh/ElectricZap.mp3?dl=1")); // Electric zap Tower sound
			
			allUrls.push(new URLRequest("https://www.dropbox.com/s/6822f1aiq6xrcq8/ButtonSound1.mp3?dl=1")); // Button sound
			allUrls.push(new URLRequest("https://www.dropbox.com/s/5ruhd7kz3nhfy7r/BuildPlaceSound.mp3?dl=1")); // Place Building sound
			
			allUrls.push(new URLRequest("https://www.dropbox.com/s/9d1hasnevd6y8ao/yesSir.mp3?dl=1")); // Place Unit YES SIR! sound
			allUrls.push(new URLRequest("https://www.dropbox.com/s/ukwnkmlm866vk8x/ofcourse.mp3?dl=1")); // Place Unit OFCOURSE! sound
			
			allUrls.push(new URLRequest("https://www.dropbox.com/s/02eseamaijwarew/UtopiaMyAss_01.mp3?dl=1")); // Place utopia my ass! sound
			allUrls.push(new URLRequest("https://www.dropbox.com/s/9usd79xd8h2f4cg/ready%20for%20t%20action.mp3?dl=1")); // Place I can Build it sound
			allUrls.push(new URLRequest("https://www.dropbox.com/s/dpfjei7272vs235/nahahahahaaaaa.mp3?dl=1")); // barry nahahaha! sound
			
			
			
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