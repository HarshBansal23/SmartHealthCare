<?php
class User {
    public $db;    
     /* Construct Function */
    public function __construct() {
        //$this->db = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
        $this->db = new mysqli('localhost', 'root', '', 'capstone');
        if (mysqli_connect_errno()) {
            echo "Error: Could not connect to database.";
            exit;
        }
    }
    
    /*** User Logout ***/
    public function user_logout() {
        $_SESSION['login'] = FALSE;
        session_destroy();
    }

     /*** login process ***/
    public function check_login($email, $password) {

        $password = md5($password);
        $sql = "SELECT * from users WHERE email='$email' and password='$password'";
        //checking if the username is available in the table
        $result = mysqli_query($this->db, $sql);
        $user_data = mysqli_fetch_array($result);
        $count_row = $result->num_rows;
        if ($count_row == 1) {
            // this login var will use for the session thing
            $_SESSION['login'] = true;
            $_SESSION['id'] = $user_data['users_id']; 
            $_SESSION['start'] = time(); // Taking now logged in time.
            // Ending a session in 30 minutes from the starting time.
            $_SESSION['expire'] = $_SESSION['start'] + (5 * 60);
            header("location:login.php");
            return true;
        } else {
            return false;
        }
    } 
    
     /*** Register User ***/
    public function reg_user() {
        $amNY = new DateTime('America/New_York');
        $added_time = $amNY->format('Y-m-d H:i:s');                        
        $ip = $_SERVER['REMOTE_ADDR'];
        $username = $_POST['username'];
        $password = $_POST['password'];
        $password = md5($password);
        $firstname = $_POST['firstname'];
        $lastname = $_POST['lastname'];
        $email = $_POST['email'];        
        $emergency_contact = $_POST['emergency_contact'];
        $home_phone = $_POST['home_phone'];
        $work_phone = $_POST['work_phone'];
        $blood_group = $_POST['blood_group'];
        $race = $_POST['race'];
        $gender = $_POST['gender'];
        $dob = $_POST['dob'];
        $marital_status = $_POST['marital_status'];
        $address1 = $_POST['address1'];
        $address2 = $_POST['address2'];
        $city = $_POST['city'];
        $state = $_POST['state'];
        $country = $_POST['country'];
        $zipcode = $_POST['zipcode'];
        $insurance = $_POST['insurance'];
        $past_history = $_POST['past_history'];
        $allergies = $_POST['allergies'];
        $smoker_drinker = $_POST['smoker_drinker'];
    
        if (isset($_FILES['support_images']['name'])) {
            $file_name_all = "";

            for ($i = 0; $i < count($_FILES['support_images']['name']); $i++) {
                $tmpFilePath = $_FILES['support_images']['tmp_name'][$i];
                if ($tmpFilePath != "") {
                    $path = "../images/userimages/";
                    $name = $_FILES['support_images']['name'][$i];
                    $size = $_FILES['support_images']['size'][$i];
                    list($txt, $ext) = explode(".", $name);
                    $file = time() . substr(str_replace(" ", "_", $txt), 0);
                    $info = pathinfo($file);
                    $filename = $file . "." . $ext;
                    if (move_uploaded_file($_FILES['support_images']['tmp_name'][$i], $path . $filename)) {
                        date_default_timezone_set("Canada/Central");
                        $currentdate = date("d M Y");
                        $file_name_all .= $filename . "*";
                    }
                }
            }
            $filepath = rtrim($file_name_all, '*'); //imagepath if it is present
            //echo $filepath;
        } else {
            $filepath = "";
        }
        $sql = "SELECT * FROM patient WHERE userName='$username' OR email='$email'";
        $check = $this->db->query($sql);
        $count_row = $check->num_rows;
        
        //if the username is not in db then insert to the table
        if ($count_row == 0) {
            $sql = "INSERT INTO patient SET
                    userName='$username',
                    password='$password',
                    firstname='$firstname',
                    lastname='$lastname',
                    email='$email',
                    emergency_contact ='$emergency_contact',
                    home_phone='$home_phone',                        
                    work_phone='$work_phone',
                    blood_group='$blood_group',
                    race = '$race',
                    gender = '$gender',   
                    dob = '$dob',
                    marital_status ='$marital_status',
                    address1 ='$address1',
                    address2 ='$address2',
                    city ='$city',
                    state = '$state',
                    country ='$country',
                    zipcode ='$zipcode',
                    insurance ='$insurance',
                    past_history = '$past_history',
                    allergies = '$allergies',
                    smoker_drinker ='$smoker_drinker',                            
                    image = '" . addslashes('../images/userimages/' . $filepath) . "',                  
                    active = '1',
                    ip = '$ip',
                    added_time = '$added_time'";
            //echo $sql;
            $result = mysqli_query($this->db, $sql) or die(mysqli_connect_errno() . "Data cannot inserted");
            return $result;
        } else {
            return false;
        }
    }

}