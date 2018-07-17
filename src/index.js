import './main.css';
import 'ace-css/css/ace.css';
import 'font-awesome/css/font-awesome.css'
import 'bootstrap/dist/css/bootstrap.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';


Main.embed(document.getElementById('root'));

registerServiceWorker();
