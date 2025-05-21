import java.util.*;

public class RouteLoader {

    static Map<String, List<String>> routes = new HashMap<>();

    static {
        routes.put("Vikram 1", Arrays.asList("Astley Hall", "Bhel Chowk", "Dilaram Chowk", "Jakhan", "Mussoorie Diversion", "Rajpur"));
        routes.put("Vikram 2A", Arrays.asList("Parade Ground", "Sahastradhara"));
        routes.put("Vikram 2B", Arrays.asList("Parade Ground", "Raipur"));
        routes.put("Vikram 3", Arrays.asList("Parade Ground", "Araghar", "Prince Chowk", "Darshanlal Chowk", "Nehru Colony Chowk", "Rispana Pul"));
        routes.put("Vikram 4", Arrays.asList("Rispana Pul", "Kargi Chowk", "ISBT"));
        routes.put("Vikram 5", Arrays.asList("Clement Town", "ISBT", "Saharanpur Chowk", "Railway Station", "Parade Ground", "Prince Chowk", "Dilaram Chowk", "Survey Chowk"));
        routes.put("Vikram 6", Arrays.asList("Connaught Place", "Bindal Pul", "Kishan Nagar Chowk", "Kaulagarh"));
        routes.put("Vikram 7", Arrays.asList("Connaught Place", "Kishan Nagar Chowk", "Ballupur Chowk", "Chakrata Road", "Prem Nagar"));
        routes.put("Vikram 8", Arrays.asList("Survey Chowk", "Seema Dwar"));
        routes.put("Vikram 9", Arrays.asList("Connaught Place", "Bindal Pul", "Kishan Nagar Chowk", "Garhi Cantt"));

        routes.put("eBus 2A", Arrays.asList("ISBT", "Shimla Bypass", "Majra", "ITI Niranjanpur", "Sabji Mandi Chowk",
                "Patel Nagar Police Station", "Lal Pul", "PNB Patel Nagar", "Matawala Bagh", "Saharanpur Chowk",
                "Railway Station", "Prince Chowk", "Cyber Police Station", "Tehsil Chowk", "Darshan Lal Chowk",
                "Clock Tower", "Gandhi Park", "St. Joseph Academy", "Sachiwalaya", "Bhel Chowk", "Dilaram Chowk",
                "Madhuban Hotel", "Ajanta Chowk", "Survey of India", "NIVH Front Gate", "Jakhan", "Pacific Mall",
                "Inder Bawa Marg", "Mussoorie Diversion", "Sai Mandir", "Tehri House/GRD", "Rajpur"));

        routes.put("eBus 2B", Arrays.asList("ISBT", "Shimla Bypass", "Majra", "ITI Niranjanpur", "Sabji Mandi Chowk",
                "Patel Nagar Police Station", "Lal Pul", "PNB Patel Nagar", "Matawala Bagh", "Saharanpur Chowk",
                "Railway Station", "Prince Chowk", "Cyber Police Station", "Tehsil Chowk", "Darshan Lal Chowk",
                "Lansdowne Chowk", "Survey Chowk", "Raipur Chungi", "Sahastradhara Crossing", "Vikas Lok",
                "Nalapani Chowk", "Shiv Girdhar Nikunj", "Ekta Vihar", "Madhur Vihar", "Mayur Vihar",
                "Baverly Hill Shalini School", "Amrit Kunj", "Shri Durga Enclave", "SGRR", "Mandakini Vihar",
                "MDDA Colony", "Aman Vihar", "Touch Wood School", "ATS Tower", "IT Park", "Gujrara Mansingh Road",
                "Tibetan Colony", "Kirsali Gaon", "Kulhan Gaon", "Pacific Golf", "Sahastradhara"));

        routes.put("eBus 3", Arrays.asList("Dwara Chowk", "Maldevta Shiv Mandir", "Rajkiya Mahavidyalaya Maldevta",
                "Donali, Maldevta", "Asthal", "Kesharwala", "Raipur", "Hathi Khana Chowk", "Kichuwala",
                "Dobhal Chowk", "6 Number Pulia", "Kishan Bhawan", "RTI Bhawan", "Pearl Avenue Hotel",
                "Ring Road Diversion", "N.W.T College", "Kali Mandir", "DRDO", "Sahastradhara Crossing",
                "Raipur Chungi", "Survey Chowk", "Lansdowne Chowk", "Darshanlal Chowk", "Clock Tower",
                "LIC Building", "Bindal Pul", "Yamuna Colony Chowk", "Kishan Nagar Chowk", "IMA Blood Bank",
                "Ballupur Chowk", "FRI Main Gate", "Panditwari", "Doon Presidency School", "Premnagar",
                "Uttaranchal University", "Nanda ki Chowki", "Uttarakhand State Women’s Commission",
                "Uttarakhand Technical University", "Sudhowala", "Hill Grove School", "Jhanjra Hanuman Mandir",
                "Doon Global School Ayurveda College", "Shivalik Sansthan and Anusandhan Kendra",
                "Dhulkot Road", "Shiv Mandir Selaqui", "SIDCUL Gate 1"));

        routes.put("eBus 3A", Arrays.asList("ISBT", "Shimla Bypass", "Majra", "ITI Niranjanpur", "Sabji Mandi Chowk",
                "Patel Nagar Police Station", "Lal Pul", "PNB Patel Nagar", "Mata Wala Bagh", "Saharanpur Chowk",
                "Railway Station", "Prince Chowk", "Cyber Police Station", "Tehsil Chowk", "Darshanlal Chowk",
                "Clock Tower", "Kwality Chowk", "Survey Chowk", "Raipur Chungi", "Sahastradhara Crossing",
                "DRDO", "Kali Mandir", "N.W.T College", "Ring Road Diversion", "Pearl Avenue Hotel", "RTI Bhawan"));
    }

    public static List<String> findRoutes(String source, String destination) {
        List<String> result = new ArrayList<>();

        for (Map.Entry<String, List<String>> entry : routes.entrySet()) {
            List<String> stops = entry.getValue();
            if (stops.contains(source) && stops.contains(destination)) {
                result.add(entry.getKey());
            }
        }
        return result;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter Source: ");
        String source = scanner.nextLine();

        System.out.print("Enter Destination: ");
        String destination = scanner.nextLine();

        List<String> availableRoutes = findRoutes(source, destination);

        if (availableRoutes.isEmpty()) {
            System.out.println("No route covers both " + source + " and " + destination + ".");
        } else {
            System.out.println("Available routes that connect " + source + " and " + destination + ":");
            for (String route : availableRoutes) {
                System.out.println("- " + route);
            }
        }
        scanner.close();
    }
}