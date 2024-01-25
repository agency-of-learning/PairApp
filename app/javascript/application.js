import '@fortawesome/fontawesome-free/js/all';
import '@hotwired/turbo-rails';
import './controllers';
import 'trix';
import '@rails/actiontext';
import './src/direct_uploads';
import './src/inline_code';
import './src/emoji_selector';

import * as ActiveStorage from '@rails/activestorage';

ActiveStorage.start();
