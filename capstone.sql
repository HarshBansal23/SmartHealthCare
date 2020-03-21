
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- Database: `capstone`

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `users_id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `active` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`users_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`users_id`, `fullname`, `password`, `email`, `active`) VALUES

--
-- Table structure for table `visit_details`
--

CREATE TABLE IF NOT EXISTS `visit_details` (
  `visit_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `doc_det_id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `doctor_name` varchar(100) DEFAULT NULL,
  `visit_reason` varchar(255) DEFAULT NULL,
  `added_by` varchar(100) DEFAULT NULL,
  `last_added_by` int(11) DEFAULT NULL,
  `added_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `updated_by_last_ip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`visit_details_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doc_det_id` (`doc_det_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `visit_details`
--

INSERT INTO `visit_details` (`visit_details_id`, `patient_id`, `doc_det_id`, `date`, `doctor_name`, `visit_reason`, `added_by`, `last_added_by`, `added_time`, `updated_time`, `updated_by_last_ip`) VALUES
(1, 1, 1, '2020-03-13 00:00:00', 'Harsh', 'Blood Check Up', 'Gupta', NULL, NULL, NULL, NULL),
(2, 1, 1, '2020-03-14 00:00:00', 'Gaurav', 'Check Up', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `visit_reason`
--

CREATE TABLE IF NOT EXISTS `visit_reason` (
  `visit_reason_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(10) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `symptoms` varchar(255) DEFAULT NULL,
  `conditions` varchar(45) DEFAULT NULL,
  `visittype` varchar(150) DEFAULT NULL,
  `precautions_taken_prior_to_visit` varchar(255) DEFAULT NULL,
  `visiting_doctor` varchar(45) DEFAULT NULL,
  `added_time` datetime DEFAULT NULL,
  `ip` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`visit_reason_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `visit_reason`
--

INSERT INTO `visit_reason` (`visit_reason_id`, `patient_id`, `reason`, `symptoms`, `conditions`, `visittype`, `precautions_taken_prior_to_visit`, `visiting_doctor`, `added_time`, `ip`) VALUES
(1, 1, 'Blood Test', 'None', 'Normal', 'Appointment', 'Fasting ', 'Dr. Harsh Bansal', '2020-03-14 14:25:27', '::1'),
(2, 1, 'General checkup', 'Low bloodpressure, sweating, dehydration', 'Normal', 'Walk-in', ' salt, blood pressure medicine', 'Dr. Gourav Sharma', '2020-03-14 06:45:03', '127.0.0.1'),

--
-- Constraints for dumped tables
--

--
-- Constraints for table `billing_details`
--
ALTER TABLE `billing_details`
  ADD CONSTRAINT `billing_details_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`);

--
-- Constraints for table `medication_details`
--
ALTER TABLE `medication_details`
  ADD CONSTRAINT `medication_details_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`);

--
-- Constraints for table `visit_details`
--
ALTER TABLE `visit_details`
  ADD CONSTRAINT `visit_details_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  ADD CONSTRAINT `visit_details_ibfk_2` FOREIGN KEY (`doc_det_id`) REFERENCES `doctors_details` (`doc_det_id`);

--
-- Constraints for table `visit_reason`
--
ALTER TABLE `visit_reason`
  ADD CONSTRAINT `visit_reason_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`);